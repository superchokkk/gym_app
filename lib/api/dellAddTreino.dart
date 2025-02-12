import 'package:http/http.dart' as http;

Future<bool> deletarTreino(int especificoId) async {
  try {
    final response = await http.delete(
      Uri.parse('http://localhost:57800/deletarTreino/$especificoId'),
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

Future<bool> adicionarTreino(int id_cliente, String nome) async {
  try {
    final response = await http.post(
      Uri.parse('http://localhost:57800/adicionarTreino/$id_cliente/$nome'),
    );
    print('Status code: ${response.statusCode}');
    
    if (response.statusCode == 200) {
      print("Treino adicionado com sucesso");
      return true;
    } else {
      print("Erro ao adicionar Treino: ${response.statusCode}");
      return false;
    }
  } catch (e) {
    print("Erro na requisição: $e");
    return false;
  }
}