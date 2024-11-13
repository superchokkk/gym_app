// ignore_for_file: file_names
import 'dart:ffi';

import 'package:gym_management/domain/models/Endereco.dart';

class Pessoa {
  BigInt id;
  String nome;
  String cpf;
  int idade;
  DateTime dataNascimento;
  Endereco endereco;
  Int log;

  Pessoa({required this.id, 
          required this.nome, 
          required this.cpf, 
          required this.idade, 
          required this.dataNascimento,
          required this.endereco,
          required this.log}
        );
}
