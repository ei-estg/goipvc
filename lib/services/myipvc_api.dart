import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:myipvc_budget_flutter/models/myipvc_curricular_unit.dart';
import 'package:myipvc_budget_flutter/models/myipvc_lesson.dart';
import 'package:myipvc_budget_flutter/services/encryptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/myipvc_card.dart';
import '../models/myipvc_detailed_curricular_unit.dart';
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

  Future<String?> login(String username, String password) async {
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
        return jsonEncode(response.data["user"]);
      }

      return null;
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
      options: Options(
        validateStatus: (status) {
          return status! < 500;
        },
      )
    );

    if(response.statusCode == 400){
      return -1;
    }

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
    final response = await _dio.post(
      "$_baseURL/api/ipvc/GetHorario",
      data: jsonEncode(<String, String>{
        'token': await getToken(),
      }),
    );

    List<MyIPVCLesson> schedule = [];

    for(var lesson in response.data){
      // Filtering the title out of a string of random stuff
      lesson["hor_nome"] = lesson["hor_nome"].split("-")[1];

      // Trimming down the teachers names
      List<String> teachers = lesson["nomesDocentes"].split("; ");
      teachers.removeWhere((element) => element == "N/D");
      for(int i = 0; i < teachers.length; i++) {
        List<String> splitName = teachers[i].split(" ");

        teachers[i] = "${splitName[0]} ${splitName[splitName.length - 1]}";
      }
      lesson["nomesDocentes"] = teachers
          .map((e) => e)
          .join("; ");

      if(lesson["nomesDocentes"] == "") {
        lesson["nomesDocentes"] = "Desconhecido";
      }

      // Removing the school name from the room string
      lesson["sala"] = lesson["sala"].split(" - ")[1];

      schedule.add(MyIPVCLesson.fromJson(lesson));
    }

    return schedule;
  }

  Future<List<MyIPVCCurricularUnit>> getCurricularPlan() async {
    final response = await _dio.post(
      "$_baseURL/api/Ipvc/GetPlanoEstudosByCurso",
      data: jsonEncode(<String, String>{
        'token': await getToken(),
      }),
    );

    List<MyIPVCCurricularUnit> curricularPlan = [];

    for(var curricularUnit in response.data["data"]){
      curricularPlan.add(MyIPVCCurricularUnit.fromJson(curricularUnit));
    }

    return curricularPlan;
  }

  Future<MyIPVCDetailedCurricularUnit> getDetailedCurricularUnit(MyIPVCCurricularUnit curricularUnit) async {
    final params = {
      "lang": "pt",
      "params": curricularUnit.toJson()
    };

    final response = await _dio.post(
      "$_baseURL/api/Ipvc/getPUC",
      data: jsonEncode(params),
    );

    MyIPVCDetailedCurricularUnit data = MyIPVCDetailedCurricularUnit.fromJson(response.data["data"][0]);

    data.docentes = data.docentes.replaceAll(RegExp(r'::\d::\d*.\d*\|\|'), "\n").trim();
    data.objetivos = data.objetivos
        .replaceAll(RegExp(r'::\d\|\|'), "\n")
        .replaceAll(RegExp(r'\d*-(?= *[A-Z])'), "");

    data.objetivos = data.objetivos
        .replaceRange(data.objetivos.length - 1, data.objetivos.length, "");

    data.conteudos = data.conteudos
        .replaceAll(RegExp(r' (?=\d+.\d+)'), "\n")
        .replaceAll(RegExp(r'::\d*.\d*::\|\|'), "\n\n")
        .replaceAll(RegExp(r'(?<=\d\.) (?=\d)'), "")
        .replaceAll(RegExp(r'(?<=[a-zA-Z]+)(?<=.)(?!$)(?=(\d\.)*\d)'), "\n")
        .replaceAll(RegExp(r'(?<=[a-zA-Z])\.(?=\d)'), ".\n")
        .replaceAll(RegExp(r'::\d*\.\d*::\d*\|\|'), "\n\n")
        .trim();

    return data;
  }

  Future<MyIPVCCard> getDigitalCard() async {
    print("start");

    final response = await _dio.get(
      "$_baseURL/api/myipvc/digitalcard/",
      data: jsonEncode(<String, String>{
        'token': await getToken(),
      }),
    );

    // Thank you to whoever thought an api should return
    // data:image/png;base64, before the base64 data
    response.data["front"] = response.data["front"].substring(22);
    response.data["back"] = response.data["back"].substring(22);

    print("hello?");

    return MyIPVCCard.fromJson(response.data);
  }
}