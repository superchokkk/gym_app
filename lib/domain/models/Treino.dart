class Treino {
  final int id;
  final String id_cliente;
  final String nome;

  Treino({
    required this.id,
    required this.id_cliente,
    required this.nome,
  });

  factory Treino.fromJson(Map<String, dynamic> json) {
    return Treino(
      id: json['id'] ?? 0,
      id_cliente: json['id_cliente']?.toString() ?? '',
      nome: json['nome'] ?? '',
    );
  }

  static List<Treino> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Treino.fromJson(json)).toList();
  }
}