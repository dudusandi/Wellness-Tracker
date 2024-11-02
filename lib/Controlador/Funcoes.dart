import 'package:WelnessTracker/Model/Exame.dart';
import 'package:WelnessTracker/Model/GerenciarBanco.dart';
import 'package:WelnessTracker/Model/Usuario.dart';

class Funcoes {
  final GerenciarBanco gerenciarBanco;
  Funcoes(this.gerenciarBanco);

  Future<void> criarExame(String nome,String dataExame,String valor, int usuarioID) async {
            Exame NovoExame = Exame(nome:nome,dataExame: dataExame, valor: valor, usuarioId: usuarioID);
            await gerenciarBanco.criarExame(NovoExame, usuarioID);
  }


  Future<void> adicionarUsuario(
      String nome, String dataNascimento, String email, String senha) async {

    Usuario novoUsuario = Usuario(
        nome: nome, dataNascimento: dataNascimento, email: email, senha: senha);
    await gerenciarBanco.criarUsuario(novoUsuario);
  }





}
