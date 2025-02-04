import 'dart:ffi';

class TreinoExercicio {
  final int id;
  final int id_treino;
  final int id_exercicio;
  final int reps;
  final Float peso;
  final DateTime data;

  TreinoExercicio({
    required this.id,
    required this.id_treino,
    required this.id_exercicio,
    required this.reps,
    required this.peso,
    required this.data,
  });

  factory TreinoExercicio.fromJson(Map<String, dynamic> json) {
    return TreinoExercicio(
      id: json['id'] ?? 0,
      id_treino: json['id_treino'] ?? 0,
      id_exercicio: json['id_exercicio'] ?? 0,
      reps: json['reps'] ?? 0,
      peso: json['peso'] ?? 0,
      data: json['data'] ?? 0
    );
  }

  static List<TreinoExercicio> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TreinoExercicio.fromJson(json)).toList();
  }
}
