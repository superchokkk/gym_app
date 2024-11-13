// ignore_for_file: file_names

import 'package:gym_management/domain/models/Pessoa.dart';

class Aluno extends Pessoa {
  bool status;
  DateTime dataInicio;

  Aluno( this.status, 
         this.dataInicio, 
         id, 
         nome, 
         cpf, 
         idade, 
         dataNascimento, 
         endereco,
         log
       )
    : super( id: id, 
             nome: nome, 
             cpf: cpf, 
             idade: idade, 
             dataNascimento: dataNascimento, 
             endereco: endereco,
             log: log
           );
}
