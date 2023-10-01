// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyIPVCLesson _$MyIPVCLessonFromJson(Map<String, dynamic> json) => MyIPVCLesson(
      dataHoraIni: json['data_hora_ini'] as String,
      dataHoraFim: json['data_hora_fim'] as String,
      sigla: json['sigla'] as String,
      horNome: json['hor_nome'] as String,
      sala: json['sala'] as String,
      horNomeTurno: json['hor_nome_turno'] as String,
      emailsDocentes: json['emailsDocentes'] as String,
      nomesDocentes: json['nomesDocentes'] as String,
      horEventoId: json['hor_evento_id'] as String,
      idEstado: json['id_estado'] as int,
      corValor: json['cor_valor'] as String,
    );

Map<String, dynamic> _$MyIPVCLessonToJson(MyIPVCLesson instance) =>
    <String, dynamic>{
      'data_hora_ini': instance.dataHoraIni,
      'data_hora_fim': instance.dataHoraFim,
      'sigla': instance.sigla,
      'hor_nome': instance.horNome,
      'sala': instance.sala,
      'hor_nome_turno': instance.horNomeTurno,
      'emailsDocentes': instance.emailsDocentes,
      'nomesDocentes': instance.nomesDocentes,
      'hor_evento_id': instance.horEventoId,
      'id_estado': instance.idEstado,
      'cor_valor': instance.corValor,
    };
