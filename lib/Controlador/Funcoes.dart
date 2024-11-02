import 'package:WelnessTracker/Estado/UsuarioLogado%20.dart';
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

void fazerLogin(String email, String senha) async {
  bool loginSucesso = await gerenciarBanco.logar(email, senha);
  if (loginSucesso) {
    Map<String, dynamic>? usuarioDados = (await gerenciarBanco.obterUsuarioPorEmail(email)) as Map<String, dynamic>?;
    if (usuarioDados != null) {
      Usuario usuario = Usuario(
        id: usuarioDados['id'],
        nome: usuarioDados['nome'],
        dataNascimento: usuarioDados['data_nascimento'],
        email: usuarioDados['email'],
        senha: senha, // Não é seguro armazenar a senha, considere removê-la
      );
      UsuarioLogado.setUsuario(usuario); // Armazena o usuário logado
    }
  }
}



}
