// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curricular_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyIPVCCurricularUnit _$MyIPVCCurricularUnitFromJson(
        Map<String, dynamic> json) =>
    MyIPVCCurricularUnit(
      escola: json['escola'] as String,
      dsGrau: json['ds_grau'] as String,
      cdCurso: json['cd_curso'] as String,
      nmCurso: json['nm_curso'] as String,
      cdPlano: json['cd_plano'] as String,
      cdRamo: json['cd_ramo'] as String,
      nmRamo: json['nm_ramo'] as String,
      cdDiscip: json['cd_discip'] as String,
      nmUnidadeCurricular: json['nm_unidade_curricular'] as String,
      anoCurricular: json['ano_curricular'] as int,
      semestreCurricular: json['semestre_curricular'] as String,
      ects: json['ects'] as String,
      t: json['t'] as String,
      tp: json['tp'] as String,
      tc: json['tc'] as String,
      p: json['p'] as String,
      pl: json['pl'] as String,
      l: json['l'] as String,
      e: json['e'] as String,
      ec: json['ec'] as String,
      s: json['s'] as String,
      o: json['o'] as String,
      ot: json['ot'] as String,
      grupoDisciplinar: json['grupo_disciplinar'] as String,
    );

Map<String, dynamic> _$MyIPVCCurricularUnitToJson(
        MyIPVCCurricularUnit instance) =>
    <String, dynamic>{
      'escola': instance.escola,
      'cd_curso': instance.cdCurso,
      'nm_curso': instance.nmCurso,
      'cd_plano': instance.cdPlano,
      'cd_ramo': instance.cdRamo,
      'nm_ramo': instance.nmRamo,
      'cd_discip': instance.cdDiscip,
      'nm_unidade_curricular': instance.nmUnidadeCurricular,
      'ds_grau': instance.dsGrau,
      'ano_curricular': instance.anoCurricular,
      'semestre_curricular': instance.semestreCurricular,
      'ects': instance.ects,
      't': instance.t,
      'tp': instance.tp,
      'tc': instance.tc,
      'p': instance.p,
      'pl': instance.pl,
      'l': instance.l,
      'e': instance.e,
      'ec': instance.ec,
      's': instance.s,
      'o': instance.o,
      'ot': instance.ot,
      'grupo_disciplinar': instance.grupoDisciplinar,
    };
