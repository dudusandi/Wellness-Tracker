import 'package:sqlite3/sqlite3.dart';
import 'dart:ffi';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class GerenciarBanco {



Future<void> criarUsuario(String nome, String dataNascimento, String email, String senha) async {
  DynamicLibrary.open('assets/sqlite3.dll');
  final directory = await getApplicationDocumentsDirectory();
  final dbPath = join(directory.path, 'WellnessTrackerDatabase.db');
  final Database db = sqlite3.open(dbPath);
    db.execute(
      'INSERT INTO usuarios (nome, data_nascimento, email, senha) VALUES (?, ?, ?, ?)',
      [nome, dataNascimento, email, senha]
    );
  print('Usuário $nome adicionado com sucesso!'); 
  db.dispose();
}

Future<bool> logar(String email, String senha) async {
  DynamicLibrary.open('assets/sqlite3.dll');
  final directory = await getApplicationDocumentsDirectory();
  final dbPath = join(directory.path, 'WellnessTrackerDatabase.db');
  final Database db = sqlite3.open(dbPath);

  final ResultSet result = db.select(
    'SELECT * FROM usuarios WHERE email = ? AND senha = ?',
    [email, senha],
    
  );

  db.dispose();

  return result.isNotEmpty;
}

 Future<Map<String, dynamic>?> obterUsuarioPorEmail(String email) async {
    DynamicLibrary.open('assets/sqlite3.dll');
  final directory = await getApplicationDocumentsDirectory();
  final dbPath = join(directory.path, 'WellnessTrackerDatabase.db');
  final Database db = sqlite3.open(dbPath);

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