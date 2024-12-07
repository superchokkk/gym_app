class Cliente {
  final int id;
  final String nome;
  final int cpf;
  final String email;
  final String senha;
  final int nivel;
  final int idade;
  final double peso;
  final double altura;

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
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'] ?? 0,
      nome: json['nome'] ?? '',
      cpf: json['cpf'] ?? '',
      email: json['email'] ?? '',
      idade: json['idade'] ?? 0,
      peso: json['peso']?.toDouble() ?? 0.0,
      altura: json['altura']?.toDouble() ?? 0.0,
      senha: json['senha'] ?? '',
      nivel: json['priv'] ?? 2,
    );
  }
}