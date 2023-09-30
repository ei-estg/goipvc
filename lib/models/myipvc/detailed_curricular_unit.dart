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

  String cdLetivo;
  String cdCurso;
  String nmCurso;
  String cdPlano;
  String nmPlano;
  String cdRamo;
  String nmRamo;
  String cdDiscip;
  String dsDiscip;
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
  String bibliografiaPrincipal;
  String bibliografiaComplementar;
  String conteudos;
  String docentes;
  String objetivos;

  factory MyIPVCDetailedCurricularUnit.fromJson(Map<String, dynamic> json) =>
      _$MyIPVCDetailedCurricularUnitFromJson(json);
  Map<String, dynamic> toJson() => _$MyIPVCDetailedCurricularUnitToJson(this);
}
