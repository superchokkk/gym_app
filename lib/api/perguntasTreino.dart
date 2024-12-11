import 'dart:convert';
import 'package:http/http.dart' as http;
import '../domain/models/Treino.dart';

Future<List<Treino>> fetchTreinos(int referencia) async {
  final url = Uri.parse('http://localhost:57800/buscaTreinos');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'referencia': referencia}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return Treino.fromJsonList(jsonList);
    } else {
      throw Exception('Falha ao carregar treinos: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Erro: $e');
  }
}
