import 'package:http/http.dart' as http;

Future<bool> adicionarExercicioNovo(String nome, int id_grupo) async {
  try {
    final response = await http.post(
      Uri.parse('http://localhost:57800/adicionarExercicio/$nome/$id_grupo'),
    );
    
    if (response.statusCode == 200) {
      return true;
    } else {
      print("Erro ao adicionar exercício: ${response.statusCode}");
      return false;
    }
  } catch (e) {
    print("Erro na requisição: $e");
    return false;
  }
}

Future<bool> achaGrupo(String nome, String grupo) async {
  try {
    final response = await http.get(
      Uri.parse('http://localhost:57800/achaGrupo/$grupo'),
    );
    
    if (response.statusCode == 200) {
      int idGrupo = int.parse(response.body);
      print("Grupo encontrado com sucesso: ID $idGrupo");
      await adicionarExercicioNovo(nome, idGrupo);
      return true;
    } else {
      print("Erro ao encontrar grupo: ${response.statusCode}");
      return false;
    }
  } catch (e) {
    print("Erro na requisição: $e");
    return false;
  }
}