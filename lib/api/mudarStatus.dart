import 'package:http/http.dart' as http;
import '../domain/models/Cliente.dart';
import 'dart:convert';

Future<bool> atualizarDataPgto(int clienteId) async {
  try {
    final response = await http.post(
      Uri.parse('http://localhost:57800/atualizarDataPgto/$clienteId'),
    );

    if (response.statusCode == 200) {
      print('Status de pagamento atualizado com sucesso');
      return true;
    } else {
      print('Erro ao atualizar status: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Erro na requisição: $e');
    return false;
  }
}

Future<Cliente> fecthClientesId(int ref) async {
  final parametro = jsonEncode({'busca': ref});
  print('Sending request with parameter: $parametro');

  try {
    final url = Uri.parse("http://localhost:57800/buscaClienteId");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: parametro,
    );
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('JSON recebido: $data');
      return Cliente.fromJson(data);
    } else {
      throw Exception('API Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Error details: $e');
    throw Exception('API Connection Error: $e');
  }
}