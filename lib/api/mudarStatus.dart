import 'package:http/http.dart' as http;
import '../domain/models/Cliente.dart';
import 'dart:convert';

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
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Cliente.fromJson(data);
    } else {
      throw Exception('API Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Error details: $e');
    throw Exception('API Connection Error: $e');
  }
}