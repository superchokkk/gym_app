import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> deletaEspecifico(int especificoId) async {
  try {
    final response = await http.delete(
      Uri.parse('http://localhost:57800/deletarSerie/$especificoId'),
    );
    print('Status code: ${response.statusCode}');
    
    if (response.statusCode == 200) {
      print("Série deletada com sucesso");
      return true;
    } else {
      print("Erro ao deletar série: ${response.statusCode}");
      return false;
    }
  } catch (e) {
    print("Erro na requisição: $e");
    return false;
  }
}

void adicionarEspecifico(int treinoId, int exercicioId, int reps, int peso) async {
  try {
    final response = await http.post(
      Uri.parse('http://localhost:57800/adicionarSerie/$treinoId/$exercicioId/$reps/$peso'),
    );
    print('Status code: ${response.statusCode}');
    
    if (response.statusCode == 200) {
      print("Série adicionada com sucesso");
      return;
    } else {
      print("Erro ao adicionar série: ${response.statusCode}");
      return;
    }
  } catch (e) {
    print("Erro na requisição: $e");
    return;
  }
}