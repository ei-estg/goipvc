import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:goipvc/models/myipvc/user.dart';
import 'package:goipvc/models/sas/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SASApiStatus { noConnection, loggedOut, loggedIn }

class SAS {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://sasocial.sas.ipvc.pt/api"
  ));

  static final Map<String, int> canteenIDs = HashMap.from({
    "ESTG": 1,
    "ESE": 2,
    "ESS": 3,
    "ESDL": 4,
    "ESCE": 5,
    "ESA": 7
  });
  
  static Future<String> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString("sas_token") ?? "";
  }

  static Future<SASApiStatus> fetchAccessToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final response = await _dio.post(
        "/authorization/authorize/refresh-token/WEB",
        options: Options(
          headers: {
            'Cookie': 'refreshTokenWEB=${prefs.getString("sas_refresh")}',
          }
        ),
      );

      final setCookieHeader = response.headers['set-cookie'] as List<String>;
      prefs.setString("sas_refresh",
          setCookieHeader[0].split('=')[1].split(';')[0]
      );
      prefs.setString("sas_token", response.data['data'][0]['token'] as String);

      return SASApiStatus.loggedIn;
    } on DioException catch(exception) {
      if(exception.type == DioExceptionType.connectionTimeout){
        return SASApiStatus.loggedOut;
      }
      return SASApiStatus.loggedOut;
    }
  }

  static Future<int> login(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await _dio.post(
      "/authorization/authorize/device-type/WEB",
      data: {
        'email': "$username@ipvc.pt",
        'password': password,
      },
      options: Options(
        validateStatus: (status) {
          return status! <= 401;
        },
      )
    );

    if(response.statusCode == 400) return -1;

    if(response.data["status"] == "success") {
      final setCookieHeader = response.headers['set-cookie'] as List<String>;

      prefs.setString("sas_token", response.data['data'][0]['token'] as String);
      prefs.setString("sas_refresh",
          setCookieHeader[0].split('=')[1].split(';')[0]
      );

      return 1;
    }

    return 0;
  }

  static Future<List<SASMeal>> getMeals(String date, String mealType) async {
    final token = await getAccessToken();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString("user");

    if(user == null) return [];

    int? canteenID = canteenIDs[
      MyIPVCUser.fromJson(jsonDecode(user)).unidadeOrganica
    ];

    if(canteenID == null) return [];

    final lunchMeals = await _dio.get(
      "/alimentation/menu/service/$canteenID/menus/$date/$mealType?withRelated=taxes,file",
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    List<SASMeal> meals = [];

    for(var meal in lunchMeals.data['data']) {
      meals.add(SASMeal(
          meal: meal["meal"],
          id: meal["id"],
          name: meal["translations"]
                  .where((obj) => obj["language_id"] == 3).first["name"]
                ?? meal["translations"][0]["name"],
          price: meal["price"],
          type: meal["type"]["translations"][0]["name"],
          location: meal["location"],
          imageUrl: meal["file"] != null ? meal["file"]["url"] : null,
          available: meal["available"]
      ));
    }

    return meals;
  }
}