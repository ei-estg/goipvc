// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyIPVCUser _$MyIPVCUserFromJson(Map<String, dynamic> json) => MyIPVCUser(
      idUtilizador: json['id_utilizador'] as String,
      nome: json['nome'] as String,
      email: json['email'] as String,
      numUtilizador: json['num_utilizador'] as String,
      grupoDisciplinar: json['grupo_disciplinar'] as String,
      unidadeOrganica: json['unidade_organica'] as String,
      idCandidato: json['id_candidato'] as String,
      passo: json['passo'] as String,
      idRegime: json['id_regime'] as String,
      idCurso: json['id_curso'] as String,
      nmCurso: json['nm_curso'] as String,
      siglaCurso: json['sigla_curso'] as String,
      tipo: json['tipo'] as String,
      fotografia: json['fotografia'] as String?,
    );

Map<String, dynamic> _$MyIPVCUserToJson(MyIPVCUser instance) =>
    <String, dynamic>{
      'id_utilizador': instance.idUtilizador,
      'nome': instance.nome,
      'email': instance.email,
      'num_utilizador': instance.numUtilizador,
      'grupo_disciplinar': instance.grupoDisciplinar,
      'unidade_organica': instance.unidadeOrganica,
      'id_candidato': instance.idCandidato,
      'passo': instance.passo,
      'id_regime': instance.idRegime,
      'id_curso': instance.idCurso,
      'nm_curso': instance.nmCurso,
      'sigla_curso': instance.siglaCurso,
      'tipo': instance.tipo,
      'fotografia': instance.fotografia,
    };
