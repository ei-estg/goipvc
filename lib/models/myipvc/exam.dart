import 'package:json_annotation/json_annotation.dart';

part 'exam.g.dart';

@JsonSerializable()
class MyIPVCExam {
  MyIPVCExam({
    required this.anoLetivo,
    required this.codigoAvalia,
    required this.codigoDisciplina,
    required this.codigoDuracao,
    required this.codigoGruAva,
    required this.dataExame,
    required this.turma,
    required this.uc,
  });

  String anoLetivo;
  String codigoAvalia;
  String codigoDisciplina;
  String codigoDuracao;
  String codigoGruAva;
  String dataExame;
  String turma;
  String uc;

  factory MyIPVCExam.fromJson(Map<String, dynamic> json) => _$MyIPVCExamFromJson(json);
  Map<String, dynamic> toJson() => _$MyIPVCExamToJson(this);
}