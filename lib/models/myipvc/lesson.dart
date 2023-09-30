// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'lesson.g.dart';

@JsonSerializable()
class MyIPVCLesson {
  MyIPVCLesson({
    required this.data_hora_ini,
    required this.data_hora_fim,
    required this.sigla,
    required this.hor_nome,
    required this.sala,
    required this.hor_nome_turno,
    required this.emailsDocentes,
    required this.nomesDocentes,
    required this.hor_evento_id,
    required this.id_estado,
    required this.cor_valor,
  });

  String data_hora_ini;
  String data_hora_fim;
  String sigla;
  String hor_nome;
  String sala;
  String hor_nome_turno;
  String emailsDocentes;
  String nomesDocentes;
  String hor_evento_id;
  int id_estado;
  String cor_valor;

  factory MyIPVCLesson.fromJson(Map<String, dynamic> json) => _$MyIPVCLessonFromJson(json);
  Map<String, dynamic> toJson() => _$MyIPVCLessonToJson(this);
}