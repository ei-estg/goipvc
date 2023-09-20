// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyIPVCExam _$MyIPVCExamFromJson(Map<String, dynamic> json) => MyIPVCExam(
      anoLetivo: json['anoLetivo'] as String,
      codigoAvalia: json['codigoAvalia'] as String,
      codigoDisciplina: json['codigoDisciplina'] as String,
      codigoDuracao: json['codigoDuracao'] as String,
      codigoGruAva: json['codigoGruAva'] as String,
      dataExame: json['dataExame'] as String,
      turma: json['turma'] as String,
      uc: json['uc'] as String,
    );

Map<String, dynamic> _$MyIPVCExamToJson(MyIPVCExam instance) =>
    <String, dynamic>{
      'anoLetivo': instance.anoLetivo,
      'codigoAvalia': instance.codigoAvalia,
      'codigoDisciplina': instance.codigoDisciplina,
      'codigoDuracao': instance.codigoDuracao,
      'codigoGruAva': instance.codigoGruAva,
      'dataExame': instance.dataExame,
      'turma': instance.turma,
      'uc': instance.uc,
    };
