// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyIPVCUser _$MyIPVCUserFromJson(Map<String, dynamic> json) => MyIPVCUser(
      id_utilizador: json['id_utilizador'] as String,
      nome: json['nome'] as String,
      email: json['email'] as String,
      num_utilizador: json['num_utilizador'] as String,
      grupo_disciplinar: json['grupo_disciplinar'] as String,
      unidade_organica: json['unidade_organica'] as String,
      id_candidato: json['id_candidato'] as String,
      passo: json['passo'] as String,
      id_regime: json['id_regime'] as String,
      id_curso: json['id_curso'] as String,
      nm_curso: json['nm_curso'] as String,
      sigla_curso: json['sigla_curso'] as String,
      tipo: json['tipo'] as String,
      fotografia: json['fotografia'] as String?,
    );

Map<String, dynamic> _$MyIPVCUserToJson(MyIPVCUser instance) =>
    <String, dynamic>{
      'id_utilizador': instance.id_utilizador,
      'nome': instance.nome,
      'email': instance.email,
      'num_utilizador': instance.num_utilizador,
      'grupo_disciplinar': instance.grupo_disciplinar,
      'unidade_organica': instance.unidade_organica,
      'id_candidato': instance.id_candidato,
      'passo': instance.passo,
      'id_regime': instance.id_regime,
      'id_curso': instance.id_curso,
      'nm_curso': instance.nm_curso,
      'sigla_curso': instance.sigla_curso,
      'tipo': instance.tipo,
      'fotografia': instance.fotografia,
    };
