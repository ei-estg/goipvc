import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:myipvc_budget_flutter/models/myipvc_lesson.dart';
import 'package:myipvc_budget_flutter/services/encryptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/myipvc_grade.dart';
import '../models/myipvc_user.dart';

class MyIPVCAPI {
  final _dio = Dio();
  final String _baseURL = "https://app.ipvc.pt";

  MyIPVCAPI() {
    _dio.options.headers["x-version"] = "999999";
  }

  Future<String> getToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString("token")!;
  }

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("token", token);
  }
  
  Future<MyIPVCUser> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String userData = prefs.getString("user")!;
    
    return MyIPVCUser.fromJson(jsonDecode(userData));
  }

  Future<void> saveUser(String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("user", user);
  }

  Future<bool> login(String username, String password) async {
    String encryptedPassword = encryptAESCryptoJS(password, "sAFasfe35/{ssF?A");

    final response = await _dio.post(
      "$_baseURL/api/Ipvc/Login",
      data: jsonEncode(<String, String>{
        'username': username,
        'password': encryptedPassword
      }),
    );

    if(response.statusCode == 200) {
      if(response.data["status"] == true) {
        await saveToken(response.data["jwtToken"]);
        await saveUser(jsonEncode(response.data["user"]));
      }

      return response.data["status"];
    } else {
      throw Exception("Erro ao iniciar sessão");
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("token");
    prefs.remove("user");
  }

  Future<List<MyIPVCGrade>> getGrades() async {
    final response = await _dio.post(
      "$_baseURL/api/academicos/getNotas",
      data: jsonEncode(<String, String>{
        'token': await getToken(),
      }),
    );

    List<MyIPVCGrade> gradeList = [];

    for(var grade in response.data["data"]){
      if(grade["duracao"] == "S1") grade["duracao"] = "1º Semestre";
      if(grade["duracao"] == "S2") grade["duracao"] = "2º Semestre";

      gradeList.add(MyIPVCGrade.fromJson(grade));
    }

    return gradeList;
  }

  Future<double> getFinalGrade() async {
    final response = await _dio.post(
      "$_baseURL/api/academicos/getMediaFinal",
      data: jsonEncode(<String, String>{
        'token': await getToken(),
      }),
    );

    return double.parse(response.data["data"]);
  }

  Future<bool> verifyAuth() async {
    try {
      await _dio.get(
        "$_baseURL/api/myipvc/profile",
        data: jsonEncode(<String, String>{
          'token': await getToken(),
        }),
      );

      return true;
    } catch (error) {
      return false;
    }
  }

  Future<List<MyIPVCLesson>> getSchedule() async {
    final response = await _dio.get(
      // "$_baseURL/api/ipvc/GetHorario"
      "https://mocki.io/v1/66336d77-0214-40c0-90c5-c87a541707ff",
      /*data: jsonEncode(<String, String>{
        'token': await getToken(),
      }),*/
    );

    List<MyIPVCLesson> schedule = [];

    for(var lesson in response.data){
      schedule.add(MyIPVCLesson.fromJson(lesson));
    }

    return schedule;
  }
}