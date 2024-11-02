import 'package:WelnessTracker/Model/GerenciarBanco.dart';
import 'package:WelnessTracker/Model/Usuario.dart';

class Funcoes {

      final GerenciarBanco gerenciarBanco;
      Funcoes(this.gerenciarBanco);

Future<void> criarExame(nome,dataExame,valor) async{
         final GerenciarBanco gerenciarBanco;

}

  Future<void> adicionarUsuario(String nome, String dataNascimento, String email, String senha) async {
    final Usuario usuario;
    Usuario novoUsuario = Usuario(nome: nome, dataNascimento: dataNascimento, email: email, senha: senha);
    await gerenciarBanco.criarUsuario(novoUsuario);

  }
}