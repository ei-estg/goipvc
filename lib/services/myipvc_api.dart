import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:goipvc/models/myipvc/curricular_unit.dart';
import 'package:goipvc/models/myipvc/exam.dart';
import 'package:goipvc/models/myipvc/lesson.dart';
import 'package:goipvc/services/encryptor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:html_unescape/html_unescape.dart';

import '../models/myipvc/calendar.dart';
import '../models/myipvc/card.dart';
import '../models/myipvc/detailed_curricular_unit.dart';
import '../models/myipvc/grade.dart';
import '../models/myipvc/user.dart';

enum MyIPVCStatus { noConnection, loggedOut, loggedIn }

class MyIPVCAPI {
  static final _dio = Dio(BaseOptions(
      baseUrl: "https://app.ipvc.pt", headers: {"x-version": "999999"}));

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString("token") ?? "";
  }

  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("token", token);
  }

  static Future<MyIPVCUser> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String userData = prefs.getString("user")!;

    return MyIPVCUser.fromJson(jsonDecode(userData));
  }

  static Future<String?> login(String username, String password) async {
    String encryptedPassword = encryptAESCryptoJS(password, "sAFasfe35/{ssF?A");

    final response = await _dio.post(
      "/api/Ipvc/Login",
      data: jsonEncode(<String, String>{
        'username': username,
        'password': encryptedPassword
      }),
    );

    if (response.statusCode == 200) {
      if (response.data["status"]) {
        await saveToken(response.data["jwtToken"]);
        return jsonEncode(response.data["user"]);
      }

      return null;
    } else {
      throw Exception("Erro ao iniciar sessão");
    }
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("token");
    prefs.remove("user");
  }

  static Future<List<MyIPVCGrade>> getGrades() async {
    final response = await _dio.post(
      "/api/academicos/getNotas",
      data: jsonEncode(<String, String>{
        'token': await getToken(),
      }),
    );

    List<MyIPVCGrade> gradeList = [];

    for (var grade in response.data["data"]) {
      if (grade["duracao"] == "S1") grade["duracao"] = "1º Semestre";
      if (grade["duracao"] == "S2") grade["duracao"] = "2º Semestre";

      gradeList.add(MyIPVCGrade.fromJson(grade));
    }

    return gradeList;
  }

  static Future<double> getFinalGrade() async {
    final response = await _dio.post("/api/academicos/getMediaFinal",
        data: jsonEncode(<String, String>{
          'token': await getToken(),
        }), options: Options(
      validateStatus: (status) {
        return status! < 500;
      },
    ));

    if (response.statusCode == 400) {
      return -1;
    }

    return double.parse(response.data["data"]);
  }

  static Future<MyIPVCStatus> verifyAuth() async {
    try {
      final token = await getToken();
      if (token == "") return MyIPVCStatus.loggedOut;

      await _dio.get(
        "/api/myipvc/profile",
        data: jsonEncode(<String, String>{
          'token': token,
        }),
      );

      return MyIPVCStatus.loggedIn;
    } on DioException catch (exception) {
      if (exception.type == DioExceptionType.connectionTimeout) {
        return MyIPVCStatus.noConnection;
      }
      return MyIPVCStatus.loggedOut;
    }
  }

  static Future<List<MyIPVCLesson>> getSchedule() async {
    final response = await _dio.post(
      "/api/ipvc/GetHorario",
      data: jsonEncode(<String, String>{
        'token': await getToken(),
      }),
    );

    List<MyIPVCLesson> schedule = [];

    for (var lesson in response.data) {
      var lessonNamePattern =
          RegExp(r"^(\w+\d+( . |.))(.*?(?=\s*[\/|+-;[\\]))", unicode: true)
              .firstMatch(lesson["hor_nome"]);

      // Filtering the title out of a string of random stuff
      if (lessonNamePattern != null) {
        lesson["hor_nome"] =
            lessonNamePattern.group(3)?.trim() ?? "Desconhecido";
      }

      // Trimming down the teachers names
      List<String> teachers = lesson["nomesDocentes"].split("; ");
      teachers.removeWhere((element) => element == "N/D");
      for (int i = 0; i < teachers.length; i++) {
        List<String> splitName = teachers[i].split(" ");

        teachers[i] = "${splitName[0]} ${splitName[splitName.length - 1]}";
      }
      lesson["nomesDocentes"] = teachers.map((e) => e).join("; ");

      if (lesson["nomesDocentes"] == "") {
        lesson["nomesDocentes"] = "Desconhecido";
      }

      // If the room name matches the pattern School - Room
      // remove the School part
      if (RegExp(r"^\S+ - (.*)$").hasMatch(lesson["sala"])) {
        lesson["sala"] = lesson["sala"].split(" - ")[1];
      }

      schedule.add(MyIPVCLesson.fromJson(lesson));
    }

    return schedule;
  }

  static Future<List<MyIPVCCurricularUnit>> getCurricularPlan() async {
    final response = await _dio.post(
      "/api/Ipvc/GetPlanoEstudosByCurso",
      data: jsonEncode(<String, String>{
        'token': await getToken(),
      }),
    );

    List<MyIPVCCurricularUnit> curricularPlan = [];

    for (var curricularUnit in response.data["data"]) {
      curricularPlan.add(MyIPVCCurricularUnit.fromJson(curricularUnit));
    }

    return curricularPlan;
  }

  static Future<MyIPVCDetailedCurricularUnit> getDetailedCurricularUnit(
      MyIPVCCurricularUnit curricularUnit) async {
    final params = {"lang": "pt", "params": curricularUnit.toJson()};

    final response = await _dio.post(
      "/api/Ipvc/getPUC",
      data: jsonEncode(params),
    );

    MyIPVCDetailedCurricularUnit data =
        MyIPVCDetailedCurricularUnit.fromJson(response.data["data"][0]);

    HtmlUnescape unescape = HtmlUnescape();

    data.docentes = unescape.convert(
        data.docentes.replaceAll(RegExp(r'::\d::\d*.\d*\|\|'), "\n").trim());
    data.objetivos = unescape.convert(data.objetivos
        .replaceAll(RegExp(r'::\d\|\|'), "\n")
        .replaceAll(RegExp(r'\d*-(?= *[A-Z])'), ""));

    data.objetivos = unescape.convert(data.objetivos
        .replaceRange(data.objetivos.length - 1, data.objetivos.length, "")
        .trim());

    data.conteudos = unescape.convert(data.conteudos
        .replaceAll(RegExp(r' (?=\d+.\d+)'), "\n")
        .replaceAll(RegExp(r'::\d*.\d*::\|\|'), "\n\n")
        .replaceAll(RegExp(r'(?<=\d\.) (?=\d)'), "")
        .replaceAll(RegExp(r'(?<=[a-zA-Z]+)(?<=.)(?!$)(?=(\d\.)*\d)'), "\n")
        .replaceAll(RegExp(r'(?<=[a-zA-Z])\.(?=\d)'), ".\n")
        .replaceAll(RegExp(r'::\d*\.\d*::\d*\|\|'), "\n\n")
        .trim());

    data.resumo = unescape.convert(data.resumo.trim());
    data.metodologias = unescape.convert(data.metodologias.trim());
    data.avaliacao = unescape.convert(data.avaliacao.trim());
    data.bibliografiaPrincipal =
        unescape.convert(data.bibliografiaPrincipal.trim());
    data.bibliografiaComplementar =
        unescape.convert(data.bibliografiaComplementar.trim());

    return data;
  }

  static Future<MyIPVCCard> getDigitalCard() async {
    final response = await _dio.get(
      "/api/myipvc/digitalcard/",
      data: jsonEncode(<String, String>{
        'token': await getToken(),
      }),
    );

    // Thank you to whoever thought an api should return
    // data:image/png;base64, before the base64 data
    response.data["front"] = response.data["front"].substring(22);
    response.data["back"] = response.data["back"].substring(22);

    return MyIPVCCard.fromJson(response.data);
  }

  static Future<List<MyIPVCExam>> getExams() async {
    final response = await _dio.post(
      "/api/academicos/obtemCalendarioExames",
      data: jsonEncode(<String, String>{
        'token': await getToken(),
      }),
    );

    List<MyIPVCExam> exams = [];

    for (var exam in response.data["data"]) {
      exams.add(MyIPVCExam.fromJson(exam));
    }

    return exams;
  }

  static Future<MyIPVCCalendar> getCalendar() async {
    final response = await _dio.post(
      "/api/atividadeLetiva/getCalendarioLetivo",
      data: jsonEncode(<String, String>{
        'lang': 'pt',
      }),
    );

    final data = response.data['data'];

    return MyIPVCCalendar(
        firstSemesterDates: data['Periodos']['PrimeiroSemestre'],
        secondSemesterDates: data['Periodos']['SegundoSemestre'],
        christmasBreak: data['ParagemLetiva']['Natal'],
        carnivalBreak: data['ParagemLetiva']['Carnaval'],
        easterBreak: data['ParagemLetiva']['Pascoa'],
        academicWeek: data['ParagemLetiva']['SemanaAcademica'],
        firstSemesterHolidays:
            List.castFrom(data['Feriados']['PrimeiroSemestre']),
        secondSemesterHolidays:
            List.castFrom(data['Feriados']['SegundoSemestre']),
        commemorativeDays: Map<String, String>.from(data['DiasComemorativos']),
        firstSemesterExamDates: data['PeriododeExames']
            ['EpocanormaleEpocadeRecurso']['PrimeiroSemestre'],
        secondSemesterExamDates: data['PeriododeExames']
            ['EpocanormaleEpocadeRecurso']['SegundoSemestre'],
        specialSeasonExamDates: data['PeriododeExames']['EpocaEspecial'],
        firstFee: data['PagamentodePropinas']['PrimeiraPrestacao'],
        followingFees: data['PagamentodePropinas']['Restantesprestacoes']);
  }
}
