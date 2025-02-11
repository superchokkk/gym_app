class ExercicioData {
  final int id;
  final String data;
  final int reps;
  final double peso;

  ExercicioData({
    required this.id,
    required this.data,
    required this.reps,
    required this.peso,
  });

  factory ExercicioData.fromJson(Map<String, dynamic> json) {
    return ExercicioData(
      id: json['id'],
      data: json['data'],
      reps: json['reps'],
      peso: json['peso'].toDouble(),
    );
  }
}