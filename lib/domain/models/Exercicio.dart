class Exercicio {
  final int id;
  final int id_grupo;
  final String nome;

  Exercicio({
    required this.id,
    required this.id_grupo,
    required this.nome,
  });

  factory Exercicio.fromJson(Map<String, dynamic> json) {
    return Exercicio(
      id: json['id'] ?? 0,
      id_grupo: json['id_grupo'] ?? 0,
      nome: json['nome'] ?? '',
    );
  }

  static List<Exercicio> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Exercicio.fromJson(json)).toList();
  }
}