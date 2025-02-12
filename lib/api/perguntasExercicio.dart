import 'dart:convert';
import 'package:gym_management/domain/models/Exercicio.dart';
import 'package:gym_management/domain/models/ExercicioGrupo.dart';
import 'package:http/http.dart' as http;

Future<List<Exercicio>> fetchExercicio(int referencia) async {
  final url = Uri.parse('http://localhost:57800/buscaExercicios');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'referencia': referencia}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      jsonList.forEach((element) {
        print(element);
      });
      return Exercicio.fromJsonList(jsonList);
    } else {
      throw Exception('Falha ao carregar treinos: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Erro: $e');
  }
}

Future<List<ExercicioGrupo>> fetchExercicioAll() async {
  final url = Uri.parse('http://localhost:57800/buscaExerciciosAll');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return ExercicioGrupo.fromJsonList(jsonList);
    } else {
      throw Exception('Falha ao carregar exercícios: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Erro na requisição: $e');
  }
}