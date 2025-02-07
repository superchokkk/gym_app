import 'dart:convert';
import 'package:http/http.dart' as http;
import '../domain/models/ExercicioData.dart';
import '../domain/models/Especifico.dart';

Future<List<ExercicioData>> fetchEspecifico(int treinoId, int exercicioId) async {
    final response = await http.get(
      Uri.parse('http://localhost:57800/buscaEspecifico/$treinoId/$exercicioId'),
    );
    print("voltou");
    if (response.statusCode == 200) {
      
    print("Resposta bruta: ${response.body}");
      final List<dynamic> jsonList = jsonDecode(response.body);
            print("b");

      jsonList.forEach((element) {
        print(element);
      });
            print("c");

      return jsonList.map((json) => ExercicioData.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar exercícios');
    }
  }
