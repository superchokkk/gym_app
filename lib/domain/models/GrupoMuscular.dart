class Grupomuscular {
  final int id;
  final String nome;

  Grupomuscular({
    required this.id,
    required this.nome,
  });

  factory Grupomuscular.fromJson(Map<String, dynamic> json) {
    return Grupomuscular(
      id: json['id'] ?? 0,
      nome: json['nome'] ?? '',
    );
  }

  static List<Grupomuscular> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Grupomuscular.fromJson(json)).toList();
  }
}
