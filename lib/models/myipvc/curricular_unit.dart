import 'package:json_annotation/json_annotation.dart';

part 'curricular_unit.g.dart';

@JsonSerializable()
class MyIPVCCurricularUnit {
  MyIPVCCurricularUnit({
    required this.escola,
    required this.dsGrau,
    required this.cdCurso,
    required this.nmCurso,
    required this.cdPlano,
    required this.cdRamo,
    required this.nmRamo,
    required this.cdDiscip,
    required this.nmUnidadeCurricular,
    required this.anoCurricular,
    required this.semestreCurricular,
    required this.ects,
    required this.T,
    required this.tp,
    required this.tc,
    required this.P,
    required this.pl,
    required this.L,
    required this.E,
    required this.ec,
    required this.S,
    required this.O,
    required this.ot,
    required this.grupoDisciplinar,
  });

  String escola;
  String dsGrau;
  String cdCurso;
  String nmCurso;
  String cdPlano;
  String cdRamo;
  String nmRamo;
  String cdDiscip;
  String nmUnidadeCurricular;
  int anoCurricular;
  String semestreCurricular;
  String ects;
  String T;
  String tp;
  String tc;
  String P;
  String pl;
  String L;
  String E;
  String ec;
  String S;
  String O;
  String ot;
  String grupoDisciplinar;

  factory MyIPVCCurricularUnit.fromJson(Map<String, dynamic> json) =>
      _$MyIPVCCurricularUnitFromJson(json);
  Map<String, dynamic> toJson() => _$MyIPVCCurricularUnitToJson(this);
}
