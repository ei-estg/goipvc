import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MealsView extends StatefulWidget {
  const MealsView({super.key});

  @override
  State<MealsView> createState() => _MealsViewState();
}

class _MealsViewState extends State<MealsView> {
  var token = "";
  var cookie = "";
  final _dio = Dio();
  void getMeals() async {
    const baseURL = "https://sasocial.sas.ipvc.pt/api";

    // first token and cookie needed
    final response = await _dio.post(
      "$baseURL/authorization/authorize/device-type/WEB",
      data: jsonEncode({}),
    );
    final token = response.data['data'][0]['token'] as String;
    final setCookieHeader = response.headers['set-cookie'] as List<String>;
    final cookie = setCookieHeader[0].split('=')[1].split(';')[0];

    final headerState = {
      'cookie': 'refreshTokenWEB=$cookie',
      'authorization': 'Bearer $token',
    };
    // token needed to get the meals using email password in the body like a boss
    final newReq = await _dio.post(
      "$baseURL/authorization/authorize/device-type/WEB",
      data: {
        'email': 'youremailhere@ipvc.pt',
        // you should save it in shared prefs and get it from there
        'password': 'passwordPlainText',
      },
      options: Options(
        headers: headerState
      ),
    );

    final newTokenNice = newReq.data['data'][0]['token'] as String;
    const date = "2023-09-18";
    // request to get the lunch meals
    final lunchMeals = await _dio.get(
      "$baseURL/alimentation/menu/service/1/menus/$date/lunch?withRelated=taxes,file",
      options: Options(
        headers: {
          'Authorization': 'Bearer $newTokenNice',
        },
      ),
    );

    //request to get dinner meals same shit just swap lunch with meals
    // TODO: validate if you need the query param for the taxes cause im pretty sure you don't the file might be handy to get the image of the dish if you want to be sexy with images in the app

    for(var meal in lunchMeals.data['data']) {
      log("meal ------ $meal");
    }

    setState(() {
      this.token = token;
      this.cookie = cookie;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Hello'),
          ElevatedButton(onPressed: getMeals, child: Text('click me')),
          Text("O Token é este: $token"),
          Text("O Cokie é este mano bro: $cookie")
        ],
      ),
    );
  }
}
