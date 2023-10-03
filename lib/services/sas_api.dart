import 'package:dio/dio.dart';
import 'package:goipvc/models/sas/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SAS {
  static Future<String> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString("sas_token") ?? "";
  }

  static Future<bool> fetchAccessToken() async {
    final dio = Dio();
    const String baseURL = "https://sasocial.sas.ipvc.pt/api";
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await dio.post(
      "$baseURL/authorization/authorize/refresh-token/WEB",
      options: Options(
        headers: {
          'Cookie': 'refreshTokenWEB=${prefs.getString("sas_refresh")}',
        },
        validateStatus: (status) {
          return status! <= 401;
        },
      ),
    );

    if(response.statusCode == 401) return false;

    final setCookieHeader = response.headers['set-cookie'] as List<String>;
    prefs.setString("sas_refresh",
        setCookieHeader[0].split('=')[1].split(';')[0]
    );
    prefs.setString("sas_token", response.data['data'][0]['token'] as String);

    return true;
  }

  static Future<int> login(String username, String password) async {
    final dio = Dio();
    const String baseURL = "https://sasocial.sas.ipvc.pt/api";
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await dio.post(
      "$baseURL/authorization/authorize/device-type/WEB",
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
    final dio = Dio();
    const String baseURL = "https://sasocial.sas.ipvc.pt/api";
    final token = await getAccessToken();

    final lunchMeals = await dio.get(
      "$baseURL/alimentation/menu/service/1/menus/$date/$mealType?withRelated=taxes,file",
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
          imageUrl: meal["file"]["url"]
      ));
    }

    return meals;
  }
}