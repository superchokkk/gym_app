import 'dart:convert';
import 'package:http/http.dart' as http;
import '../domain/models/Cliente.dart';

Future<List<Cliente>> fetchProfessores() async {
  try {
    final response = await http.get(
      Uri.parse('http://localhost:57800/buscaFuncionarios'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Cliente.fromJson(json)).toList();
    } else {
      print('Erro ao buscar clientes: ${response.statusCode}');
      throw Exception('Falha ao carregar clientes');
    }
  } catch (e) {
    print('Erro na requisição: $e');
    throw Exception('Erro na conexão com o servidor');
  }
}