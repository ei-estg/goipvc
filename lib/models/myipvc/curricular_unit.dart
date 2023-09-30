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
    required this.t,
    required this.tp,
    required this.tc,
    required this.p,
    required this.pl,
    required this.l,
    required this.e,
    required this.ec,
    required this.s,
    required this.o,
    required this.ot,
    required this.grupoDisciplinar,
  });

  String escola;

  @JsonKey(name: 'cd_curso')
  String cdCurso;

  @JsonKey(name: 'nm_curso')
  String nmCurso;

  @JsonKey(name: 'cd_plano')
  String cdPlano;

  @JsonKey(name: 'cd_ramo')
  String cdRamo;

  @JsonKey(name: 'nm_ramo')
  String nmRamo;

  @JsonKey(name: 'cd_discip')
  String cdDiscip;

  @JsonKey(name: 'nm_unidade_curricular')
  String nmUnidadeCurricular;

  @JsonKey(name: 'ds_grau')
  String dsGrau;

  @JsonKey(name: 'ano_curricular')
  int anoCurricular;

  @JsonKey(name: 'semestre_curricular')
  String semestreCurricular;

  String ects, t, tp, tc, p, pl, l, e, ec, s, o, ot;

  @JsonKey(name: 'grupo_disciplinar')
  String grupoDisciplinar;

  factory MyIPVCCurricularUnit.fromJson(Map<String, dynamic> json) =>
      _$MyIPVCCurricularUnitFromJson(json);
  Map<String, dynamic> toJson() => _$MyIPVCCurricularUnitToJson(this);
}
