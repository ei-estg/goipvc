import 'package:json_annotation/json_annotation.dart';

part 'myipvc_grade.g.dart';

@JsonSerializable()
class MyIPVCGrade {
  MyIPVCGrade({
    required this.codigoDisciplina,
    required this.dataAvaliacao,
    required this.disciplina,
    required this.duracao,
    required this.epocaAvaliacao,
    required this.estadoEpoca,
    required this.nota,
    required this.notaFinal,
  });

  String codigoDisciplina;
  String dataAvaliacao;
  String disciplina;
  String duracao;
  String epocaAvaliacao;
  String estadoEpoca;
  String nota;
  String notaFinal;

  factory MyIPVCGrade.fromJson(Map<String, dynamic> json) => _$MyIPVCGradeFromJson(json);
  Map<String, dynamic> toJson() => _$MyIPVCGradeToJson(this);
}