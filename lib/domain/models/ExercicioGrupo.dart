class ExercicioGrupo {
  final int id;
  final String nome;
  final int id_grupo;
  final String nome_grupo;

  ExercicioGrupo({
    required this.id,
    required this.nome,
    required this.id_grupo,
    required this.nome_grupo,
  });

  factory ExercicioGrupo.fromJson(Map<String, dynamic> json) {
    return ExercicioGrupo(
      id: json['id'] ?? 0,
      nome: json['nome'] ?? '',
      id_grupo: json['id_grupo'] ?? 0,
      nome_grupo: json['nome_grupo'] ?? '',
    );
  }

  static List<ExercicioGrupo> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ExercicioGrupo.fromJson(json)).toList();
  }
}