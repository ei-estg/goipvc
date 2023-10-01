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

  @JsonKey(name: 'data_hora_ini')
  String dataHoraIni;

  @JsonKey(name: 'data_hora_fim')
  String dataHoraFim;

  String sigla;

  @JsonKey(name: 'hor_nome')
  String horNome;

  String sala;

  @JsonKey(name: 'hor_nome_turno')
  String horNomeTurno;

  String emailsDocentes, nomesDocentes;

  @JsonKey(name: 'hor_evento_id')
  String horEventoId;

  @JsonKey(name: 'id_estado')
  int idEstado;

  @JsonKey(name: 'cor_valor')
  String corValor;

  factory MyIPVCLesson.fromJson(Map<String, dynamic> json) =>
      _$MyIPVCLessonFromJson(json);
  Map<String, dynamic> toJson() => _$MyIPVCLessonToJson(this);
}
