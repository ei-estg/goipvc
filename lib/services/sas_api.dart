import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SAS {
  static Future<String> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString("sas_token") ?? "";
  }

  static Future<bool> login(String username, String password) async {
    final dio = Dio();
    const String baseURL = "https://sasocial.sas.ipvc.pt/api";
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await dio.post(
      "$baseURL/authorization/authorize/device-type/WEB",
      data: {
        'email': username,
        'password': password,
      },
    );

    if(response.data["status"] == "success") {
      final setCookieHeader = response.headers['set-cookie'] as List<String>;

      prefs.setString("sas_token", response.data['data'][0]['token'] as String);
      prefs.setString("sas_refresh",
          setCookieHeader[0].split('=')[1].split(';')[0]
      );

      return true;
    }

    return false;
  }

  static Future<void> getMeals(String date) async {
    final dio = Dio();
    const String baseURL = "https://sasocial.sas.ipvc.pt/api";
    final token = await getAccessToken();

    final lunchMeals = await dio.get(
      "$baseURL/alimentation/menu/service/1/menus/$date/lunch?withRelated=taxes,file",
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    for(var meal in lunchMeals.data['data']) {
      print("meal ------ $meal");
    }
  }
}