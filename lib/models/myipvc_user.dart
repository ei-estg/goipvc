class MyIPVCUser {
  final String id_utilizador;
  final String nome;
  final String email;
  final String num_utilizador;
  final String grupo_disciplinar;
  final String unidade_organica;
  final String id_candidato;
  final String passo;
  final String id_regime;
  final String id_curso;
  final String nm_curso;
  final String sigla_curso;
  final String tipo;
  final String fotografia;

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

  factory MyIPVCUser.fromJson(Map<String, dynamic> json) {
    return MyIPVCUser(
        id_utilizador: json['id_utilizador'],
        nome: json['nome'],
        email: json['email'],
        num_utilizador: json['num_utilizador'],
        grupo_disciplinar: json['grupo_disciplinar'],
        unidade_organica: json['unidade_organica'],
        id_candidato: json['id_candidato'],
        passo: json['passo'],
        id_regime: json['id_regime'],
        id_curso: json['id_curso'],
        nm_curso: json['nm_curso'],
        sigla_curso: json['sigla_curso'],
        tipo: json['tipo'],
        fotografia: json['fotografia']
    );
  }
}