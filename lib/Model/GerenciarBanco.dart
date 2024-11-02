import 'package:WelnessTracker/Model/Exame.dart';
import 'package:WelnessTracker/Model/Usuario.dart';
import 'package:sqlite3/sqlite3.dart';
import 'dart:async';

class GerenciarBanco {


Future<void> criarUsuario(Usuario usuario) async {
  final banco = 'banco.db';
  final db = sqlite3.open(banco);

    db.execute(
      'INSERT INTO usuarios (nome, data_nascimento, email, senha) VALUES (?, ?, ?, ?)',
      [usuario.nome, usuario.dataNascimento, usuario.email, usuario.senha]
    );
  print('Usuário ${usuario.nome} adicionado com sucesso!'); 
  db.dispose();
}

Future<void> criarExame(Exame exame) async {
  final banco = 'banco.db';
  final db = sqlite3.open(banco);

    db.execute(
      'INSERT INTO exames (nome, data_exame, valor) VALUES (?, ?, ?)',
      [exame.nome, exame.dataExame, exame.valor]
    );
  db.dispose();
}


Future<bool> logar(String email, String senha) async {
  final banco = 'banco.db';
  final db = sqlite3.open(banco);

  final ResultSet result = db.select(
    'SELECT * FROM usuarios WHERE email = ? AND senha = ?',
    [email, senha],
    
  );

  db.dispose();

  return result.isNotEmpty;
}

 Future<Map<String, dynamic>?> obterUsuarioPorEmail(String email) async {
  final banco = 'banco.db';
  final db = sqlite3.open(banco);

    final result = db.select('''
      SELECT * FROM usuarios 
      WHERE email = ?
    ''', [email]);

    if (result.isNotEmpty) {
      return {
        'id': result.first['id'],
        'nome': result.first['nome'],
        'data_nascimento': result.first['data_nascimento'],
        'email': result.first['email'],
      };
    }

    return null; 
  }


}