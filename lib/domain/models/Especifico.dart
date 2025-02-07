class Especifico {
  final int id;
  final int id_treino;
  final int id_exercicio;
  final int reps;
  final int peso;
  final String data;

  Especifico({
    required this.id,
    required this.id_treino,
    required this.id_exercicio,
    required this.reps,
    required this.peso,
    required this.data,
  });

  factory Especifico.fromJson(Map<String, dynamic> json) {
    return Especifico(
      id: json['id'] ?? 0,
      id_treino: json['id_treino'] ?? 0,
      id_exercicio: json['id_exercicio'] ?? 0,
      reps: json['reps'] ?? 0,
      peso: json['peso'] ?? 0,
      data: json['data'] ?? ''
    );
  }

  static List<Especifico> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Especifico.fromJson(json)).toList();
  }
}