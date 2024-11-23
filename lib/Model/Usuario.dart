class Usuario {
  int? id;
  String nome;
  String dataNascimento;
  String senha;
  String email;
  double? frequenciaExercicio;
  String? comorbidades;
  String? medicacoes;
  bool? isSwitched;

  Usuario({
    
  required this.nome, 
  required this.dataNascimento, 
  required this.email, 
  required this.senha, 
  this.id,
  this.frequenciaExercicio,
  this.comorbidades,
  this.medicacoes,
  this.isSwitched
  

  
  });
}