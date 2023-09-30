import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class MyIPVCUser {
  MyIPVCUser(
      {required this.idUtilizador,
      required this.nome,
      required this.email,
      required this.numUtilizador,
      required this.grupoDisciplinar,
      required this.unidadeOrganica,
      required this.idCandidato,
      required this.passo,
      required this.idRegime,
      required this.idCurso,
      required this.nmCurso,
      required this.siglaCurso,
      required this.tipo,
      required this.fotografia});

  String idUtilizador;
  String nome;
  String email;
  String numUtilizador;
  String grupoDisciplinar;
  String unidadeOrganica;
  String idCandidato;
  String passo;
  String idRegime;
  String idCurso;
  String nmCurso;
  String siglaCurso;
  String tipo;
  String? fotografia;

  factory MyIPVCUser.fromJson(Map<String, dynamic> json) =>
      _$MyIPVCUserFromJson(json);
  Map<String, dynamic> toJson() => _$MyIPVCUserToJson(this);
}
