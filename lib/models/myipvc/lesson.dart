import 'package:json_annotation/json_annotation.dart';

part 'lesson.g.dart';

@JsonSerializable()
class MyIPVCLesson {
  MyIPVCLesson({
    required this.dataHoraIni,
    required this.dataHoraFim,
    required this.sigla,
    required this.horNome,
    required this.sala,
    required this.horNomeTurno,
    required this.emailsDocentes,
    required this.nomesDocentes,
    required this.horEventoId,
    required this.idEstado,
    required this.corValor,
  });

  String dataHoraIni;
  String dataHoraFim;
  String sigla;
  String horNome;
  String sala;
  String horNomeTurno;
  String emailsDocentes;
  String nomesDocentes;
  String horEventoId;
  int idEstado;
  String corValor;

  factory MyIPVCLesson.fromJson(Map<String, dynamic> json) =>
      _$MyIPVCLessonFromJson(json);
  Map<String, dynamic> toJson() => _$MyIPVCLessonToJson(this);
}
