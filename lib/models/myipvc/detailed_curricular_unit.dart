import 'package:json_annotation/json_annotation.dart';

part 'detailed_curricular_unit.g.dart';

@JsonSerializable()
class MyIPVCDetailedCurricularUnit {
  MyIPVCDetailedCurricularUnit(
      {required this.cdLetivo,
      required this.cdCurso,
      required this.nmCurso,
      required this.cdPlano,
      required this.nmPlano,
      required this.cdRamo,
      required this.nmRamo,
      required this.cdDiscip,
      required this.dsDiscip,
      required this.ano,
      required this.semestre,
      required this.ects,
      required this.grau,
      required this.t,
      required this.tp,
      required this.p,
      required this.l,
      required this.pl,
      required this.tc,
      required this.s,
      required this.e,
      required this.ec,
      required this.o,
      required this.ot,
      required this.resumo,
      required this.metodologias,
      required this.avaliacao,
      required this.bibliografiaPrincipal,
      required this.bibliografiaComplementar,
      required this.conteudos,
      required this.docentes,
      required this.objetivos});

  @JsonKey(name: 'cd_letivo')
  String cdLetivo;

  @JsonKey(name: 'cd_curso')
  String cdCurso;

  @JsonKey(name: 'nm_curso')
  String nmCurso;

  @JsonKey(name: 'cd_plano')
  String cdPlano;

  @JsonKey(name: 'nm_plano')
  String nmPlano;

  @JsonKey(name: 'cd_ramo')
  String cdRamo;

  @JsonKey(name: 'nm_ramo')
  String nmRamo;

  @JsonKey(name: 'cd_discip')
  String cdDiscip;

  @JsonKey(name: 'ds_discip')
  String dsDiscip;

  int ano;

  String semestre,
      ects,
      grau,
      t,
      tp,
      p,
      l,
      pl,
      tc,
      s,
      e,
      ec,
      o,
      ot,
      resumo,
      metodologias,
      avaliacao;

  @JsonKey(name: 'bibliografia_principal')
  String bibliografiaPrincipal;
  @JsonKey(name: 'bibliografia_complementar')
  String bibliografiaComplementar;

  String conteudos, docentes, objetivos;

  factory MyIPVCDetailedCurricularUnit.fromJson(Map<String, dynamic> json) =>
      _$MyIPVCDetailedCurricularUnitFromJson(json);
  Map<String, dynamic> toJson() => _$MyIPVCDetailedCurricularUnitToJson(this);
}
