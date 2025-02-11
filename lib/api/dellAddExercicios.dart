import 'package:http/http.dart' as http;

Future<bool> deletarExercicio(int id_treino, int id_exercicio) async {
  try {
    final response = await http.delete(
      Uri.parse('http://localhost:57800/deletarExercicio/$id_treino/$id_exercicio'),
    );
    print('Status code: ${response.statusCode}');
    
    if (response.statusCode == 200) {
      print("deletada com sucesso");
      return true;
    } else {
      print("Erro ao deletar: ${response.statusCode}");
      return false;
    }
  } catch (e) {
    print("Erro na requisição: $e");
    return false;
  }
}

void adicionarExercicio(int treinoId, int exercicioId, int reps, int peso) async {
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