class Cliente {
  final int id;
  final String nome;
  final String cpf;
  final String email;
  final String senha;
  final int nivel;
  final int idade;
  final double peso;
  final double altura;
  final String data;

  Cliente({
    required this.id,
    required this.nome,
    required this.cpf,
    required this.email,
    required this.senha,
    required this.nivel,
    required this.idade,
    required this.peso,
    required this.altura,
    required this.data,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
  return Cliente(
    id: json['id'] ?? 0,
    nome: json['nome'] ?? '',
    cpf: json['cpf'] ?? '',
    email: json['email'] ?? '',
    senha: json['senha'] ?? '',
    nivel: json['nivel'] ?? 9,  
    idade: json['idade'] ?? 0,
    peso: (json['peso'] ?? 0.0).toDouble(),
    altura: (json['altura'] ?? 0.0).toDouble(),
    data: json['data'] ?? ''
  );
}
}