// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyIPVCGrade _$MyIPVCGradeFromJson(Map<String, dynamic> json) => MyIPVCGrade(
      codigoDisciplina: json['codigoDisciplina'] as String,
      dataAvaliacao: json['dataAvaliacao'] as String,
      disciplina: json['disciplina'] as String,
      duracao: json['duracao'] as String,
      epocaAvaliacao: json['epocaAvaliacao'] as String,
      estadoEpoca: json['estadoEpoca'] as String,
      nota: json['nota'] as String,
      notaFinal: json['notaFinal'] as String,
    );

Map<String, dynamic> _$MyIPVCGradeToJson(MyIPVCGrade instance) =>
    <String, dynamic>{
      'codigoDisciplina': instance.codigoDisciplina,
      'dataAvaliacao': instance.dataAvaliacao,
      'disciplina': instance.disciplina,
      'duracao': instance.duracao,
      'epocaAvaliacao': instance.epocaAvaliacao,
      'estadoEpoca': instance.estadoEpoca,
      'nota': instance.nota,
      'notaFinal': instance.notaFinal,
    };
