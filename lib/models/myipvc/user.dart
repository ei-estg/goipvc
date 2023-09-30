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

  @JsonKey(name: 'id_utilizador')
  String idUtilizador;

  String nome, email;

  @JsonKey(name: 'num_utilizador')
  String numUtilizador;

  @JsonKey(name: 'grupo_disciplinar')
  String grupoDisciplinar;

  @JsonKey(name: 'unidade_organica')
  String unidadeOrganica;

  @JsonKey(name: 'id_candidato')
  String idCandidato;

  String passo;

  @JsonKey(name: 'id_regime')
  String idRegime;

  @JsonKey(name: 'id_curso')
  String idCurso;

  @JsonKey(name: 'nm_curso')
  String nmCurso;

  @JsonKey(name: 'sigla_curso')
  String siglaCurso;

  String tipo;
  String? fotografia;

  factory MyIPVCUser.fromJson(Map<String, dynamic> json) =>
      _$MyIPVCUserFromJson(json);
  Map<String, dynamic> toJson() => _$MyIPVCUserToJson(this);
}
