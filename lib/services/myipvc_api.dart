import 'dart:async';
import 'dart:convert';
import 'package:cryptography/cryptography.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/myipvc_grade.dart';
import '../models/myipvc_user.dart';

const String _baseURL = "https://app.ipvc.pt";

class MyIPVCLoginResponse {
  final bool status;
  final String jwtToken;
  final MyIPVCUser user;

  MyIPVCLoginResponse({
    required this.status,
    required this.jwtToken,
    required this.user
  });

  factory MyIPVCLoginResponse.fromJson(Map<String, dynamic> json) {
    return MyIPVCLoginResponse(
      status: json['status'],
      jwtToken: json['jwtToken'],
      user: json['user']
    );
  }
}

class MyIPVCAPI {
  final _dio = Dio();

  MyIPVCAPI() {
    _dio.options.headers["x-version"] = "999999";
  }

  Future<String> getToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString("token")!;
  }

  Future<bool> login(String username, String password) async {
    final algorithm = AesCbc.with128bits(macAlgorithm: MacAlgorithm.empty);
    var key = await algorithm.newSecretKeyFromBytes(utf8.encode("sAFasfe35/{ssF?A"));
    final secret = await algorithm.encryptString(password, secretKey: key);
    final concatenatedBytes = base64Encode(secret.concatenation());

    print(concatenatedBytes);

    final response = await _dio.post(
      "$_baseURL/api/Ipvc/Login",
      data: jsonEncode(<String, String>{
        'username': username,
        'password': concatenatedBytes
      }),
    );

    if(response.statusCode == 200) {
      //final MyIPVCLoginResponse res = MyIPVCLoginResponse.fromJson(response.data);
      print(response.data["status"]);
      return response.data["status"];
    } else {
      throw Exception("Erro ao iniciar sessão");
    }
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
}