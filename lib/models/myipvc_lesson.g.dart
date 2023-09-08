// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myipvc_lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyIPVCLesson _$MyIPVCLessonFromJson(Map<String, dynamic> json) => MyIPVCLesson(
      data_hora_ini: json['data_hora_ini'] as String,
      data_hora_fim: json['data_hora_fim'] as String,
      sigla: json['sigla'] as String,
      hor_nome: json['hor_nome'] as String,
      sala: json['sala'] as String,
      hor_nome_turno: json['hor_nome_turno'] as String,
      emailsDocentes: json['emailsDocentes'] as String,
      nomesDocentes: json['nomesDocentes'] as String,
      hor_evento_id: json['hor_evento_id'] as String,
      id_estado: json['id_estado'] as String,
      cor_valor: json['cor_valor'] as String,
    );

Map<String, dynamic> _$MyIPVCLessonToJson(MyIPVCLesson instance) =>
    <String, dynamic>{
      'data_hora_ini': instance.data_hora_ini,
      'data_hora_fim': instance.data_hora_fim,
      'sigla': instance.sigla,
      'hor_nome': instance.hor_nome,
      'sala': instance.sala,
      'hor_nome_turno': instance.hor_nome_turno,
      'emailsDocentes': instance.emailsDocentes,
      'nomesDocentes': instance.nomesDocentes,
      'hor_evento_id': instance.hor_evento_id,
      'id_estado': instance.id_estado,
      'cor_valor': instance.cor_valor,
    };
