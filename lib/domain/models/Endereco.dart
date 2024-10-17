import 'package:gym_management/domain/models/Cidade.dart';

class Endereco {
  String rua;
  String numero;
  String complemento;
  String bairro;
  Cidade cidade;

  Endereco({required this.rua, 
            required this.numero, 
            required this.complemento, 
            required this.bairro, 
            required this.cidade}
          );
}
