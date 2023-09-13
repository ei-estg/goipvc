import 'package:json_annotation/json_annotation.dart';

part 'myipvc_curricular_unit.g.dart';

@JsonSerializable()
class MyIPVCCurricularUnit {
  MyIPVCCurricularUnit({
    required this.escola,
    required this.ds_grau,
    required this.cd_curso,
    required this.nm_curso,
    required this.cd_plano,
    required this.cd_ramo,
    required this.nm_ramo,
    required this.cd_discip,
    required this.nm_unidade_curricular,
    required this.ano_curricular,
    required this.semestre_curricular,
    required this.ects,
    required this.T,
    required this.TP,
    required this.TC,
    required this.P,
    required this.PL,
    required this.L,
    required this.E,
    required this.EC,
    required this.S,
    required this.O,
    required this.OT,
    required this.grupo_disciplinar,
  });

  String escola;
  String ds_grau;
  String cd_curso;
  String nm_curso;
  String cd_plano;
  String cd_ramo;
  String nm_ramo;
  String cd_discip;
  String nm_unidade_curricular;
  int ano_curricular;
  String semestre_curricular;
  String ects;
  String T;
  String TP;
  String TC;
  String P;
  String PL;
  String L;
  String E;
  String EC;
  String S;
  String O;
  String OT;
  String grupo_disciplinar;

  factory MyIPVCCurricularUnit.fromJson(Map<String, dynamic> json) => _$MyIPVCCurricularUnitFromJson(json);
  Map<String, dynamic> toJson() => _$MyIPVCCurricularUnitToJson(this);
}