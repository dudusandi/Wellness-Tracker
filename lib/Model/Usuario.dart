class Usuario {
  int? id;
  String nome;
  String dataNascimento;
  String senha;
  String email;

  Usuario({required this.nome, required this.dataNascimento, required this.email, required this.senha, this.id});
}