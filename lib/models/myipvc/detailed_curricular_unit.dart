import 'package:json_annotation/json_annotation.dart';

part 'detailed_curricular_unit.g.dart';

@JsonSerializable()
class MyIPVCDetailedCurricularUnit {
  MyIPVCDetailedCurricularUnit({
    required this.cd_letivo,
    required this.cd_curso,
    required this.nm_curso,
    required this.cd_plano,
    required this.nm_plano,
    required this.cd_ramo,
    required this.nm_ramo,
    required this.cd_discip,
    required this.ds_discip,
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
    required this.bibliografia_principal,
    required this.bibliografia_complementar,
    required this.conteudos,
    required this.docentes,
    required this.objetivos
  });

  String cd_letivo;
  String cd_curso;
  String nm_curso;
  String cd_plano;
  String nm_plano;
  String cd_ramo;
  String nm_ramo;
  String cd_discip;
  String ds_discip;
  int ano;
  String semestre;
  String ects;
  String grau;
  String t;
  String tp;
  String p;
  String l;
  String pl;
  String tc;
  String s;
  String e;
  String ec;
  String o;
  String ot;
  String resumo;
  String metodologias;
  String avaliacao;
  String bibliografia_principal;
  String bibliografia_complementar;
  String conteudos;
  String docentes;
  String objetivos;

  factory MyIPVCDetailedCurricularUnit.fromJson(Map<String, dynamic> json) => _$MyIPVCDetailedCurricularUnitFromJson(json);
  Map<String, dynamic> toJson() => _$MyIPVCDetailedCurricularUnitToJson(this);
}