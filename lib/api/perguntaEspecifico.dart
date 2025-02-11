import 'dart:convert';
import 'package:http/http.dart' as http;
import '../domain/models/ExercicioData.dart';

Future<List<ExercicioData>> fetchEspecifico(int treinoId, int exercicioId) async {
    final response = await http.get(
      Uri.parse('http://localhost:57800/buscaEspecifico/$treinoId/$exercicioId'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => ExercicioData.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar exercícios');
    }
  }


