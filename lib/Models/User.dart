class User {
  final String nome;
  final String email;
  final String token;

  const User({
    required this.nome,
    required this.email,
    required this.token
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      nome: json['nome'] as String,
      email: json['email'] as String,
      token: json['token'] as String
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': this.nome,
      'email': this.email,
      'token': this.token
    };
  }
}