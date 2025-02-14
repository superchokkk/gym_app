import 'dart:convert';
import 'package:http/http.dart' as http;
import '../domain/models/Cliente.dart';

//--------------------------------------------------
//funcionarios
//--------------------------------------------------
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

Future<bool> adicionarFuncionario({
  required String nome,
  required String cpf,
  required String email,
  required String senha,
}) async {
  try {
    final response = await http.post(
      Uri.parse('http://localhost:57800/adicionarCliente'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nome': nome,
        'cpf': cpf,
        'email': email,
        'senha': 'senha',
        'nivel': 2,
        'idade': 0,
        'peso': 0,
        'altura': 0,
      }),
    );

    if (response.statusCode == 200) {
      print('Cliente adicionado com sucesso');
      return true;
    } else {
      print('Erro ao adicionar cliente: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Erro na requisição: $e');
    return false;
  }
}

Future<bool> deletarFuncionario(int clienteId) async {
  try {
    final response = await http.delete(
      Uri.parse('http://localhost:57800/deletarFuncionario/$clienteId'),
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
//--------------------------------------------------
//clientes
//--------------------------------------------------
Future<List<Cliente>> fetchClientes() async {
  try {
    final response = await http.get(
      Uri.parse('http://localhost:57800/buscaClientes'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      print(jsonList);
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

Future<bool> updateClientePgto(int clienteId, int flag) async {
  try {
    final response = await http.post(
      Uri.parse('http://localhost:57800/atualizarPgto/$clienteId/$flag'),
    );

    if (response.statusCode == 200) {
      print('Data atualizada com sucesso');
      return true;
    } else {
      print('Erro ao atualizar data: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Erro na requisição: $e');
    return false;
  }
}

Future<bool> deletarCliente(int clienteId) async {
  try {
    final response = await http.delete(
      Uri.parse('http://localhost:57800/deletarCliente/$clienteId'),
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

Future<bool> adicionarCliente({
  required String nome,
  required String cpf,  // Changed back to String
  required String email,
  required String senha,
  required int idade,
  required double peso,
  required double altura,
}) async {
  try {
    // Remove any non-numeric characters from CPF
    final cleanCpf = cpf.replaceAll(RegExp(r'[^\d]'), '');
    
    final response = await http.post(
      Uri.parse('http://localhost:57800/adicionarCliente'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nome': nome,
        'cpf': cleanCpf,  // Send cleaned CPF string
        'email': email,
        'senha': senha,
        'nivel': 3,
        'idade': idade,
        'peso': peso,
        'altura': altura,
      }),
    );

    if (response.statusCode == 200) {
      print('Cliente adicionado com sucesso');
      return true;
    } else if (response.statusCode == 400) {
      print('CPF já cadastrado');
      return false;
    } else {
      print('Erro ao adicionar cliente: ${response.statusCode}');
      print('Resposta: ${response.body}');
      return false;
    }
  } catch (e) {
    print('Erro na requisição: $e');
    return false;
  }
}
