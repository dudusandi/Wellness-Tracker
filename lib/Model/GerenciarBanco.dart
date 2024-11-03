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

Future<void> criarExame(Exame exame,int usuarioID) async {
  final banco = 'banco.db';
  final db = sqlite3.open(banco);

    db.execute(
      'INSERT INTO exames (nome, data_exame, valor, usuario_id) VALUES (?, ?, ?, ?)',
      [exame.nome, exame.dataExame, exame.valor, exame.usuarioId]
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

Future<Usuario?> obterUsuarioPorEmail(String email) async {
  final banco = 'banco.db';
  final db = sqlite3.open(banco);

  final result = db.select('''
    SELECT * FROM usuarios 
    WHERE email = ?
  ''', [email]);

  db.dispose(); 

  if (result.isNotEmpty) {
    final usuarioData = result.first;
    return Usuario(
      id: usuarioData['id'], 
      nome: usuarioData['nome'],
      dataNascimento: usuarioData['data_nascimento'],
      email: usuarioData['email'],
      senha: '', 
    );
  }

  return null; 
}

Future<List<Exame>> obterExamesPorUsuarioId(int usuarioId) async {
  final banco = 'banco.db';
  final db = sqlite3.open(banco);

  final result = db.select(
    'SELECT * FROM exames WHERE usuario_id = ?',
    [usuarioId],
  );

  db.dispose();

  return result.map((exameData) => Exame(
      nome: exameData['nome'],
      dataExame: exameData['data_exame'],
      valor: exameData['valor'],
      usuarioId: usuarioId,
    )).toList();
}


}