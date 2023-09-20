import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class MyIPVCUser {
  MyIPVCUser({
    required this.id_utilizador,
    required this.nome,
    required this.email,
    required this.num_utilizador,
    required this.grupo_disciplinar,
    required this.unidade_organica,
    required this.id_candidato,
    required this.passo,
    required this.id_regime,
    required this.id_curso,
    required this.nm_curso,
    required this.sigla_curso,
    required this.tipo,
    required this.fotografia
  });

  String id_utilizador;
  String nome;
  String email;
  String num_utilizador;
  String grupo_disciplinar;
  String unidade_organica;
  String id_candidato;
  String passo;
  String id_regime;
  String id_curso;
  String nm_curso;
  String sigla_curso;
  String tipo;
  String? fotografia;

  factory MyIPVCUser.fromJson(Map<String, dynamic> json) => _$MyIPVCUserFromJson(json);
  Map<String, dynamic> toJson() => _$MyIPVCUserToJson(this);
}