import 'package:sqlite3/sqlite3.dart';

class CriarBanco{
Future<void> criarBancoDeDados() async {

final banco = 'banco.db';
final db = sqlite3.open(banco);

db.execute('''
    CREATE TABLE IF NOT EXISTS usuarios (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      data_nascimento TEXT NOT NULL,
      email TEXT NOT NULL UNIQUE,
      senha TEXT NOT NULL
    );
''');

db.execute('''
    CREATE TABLE IF NOT EXISTS exames (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT,
      data_exame DATE,
      valor TEXT,
      usuario_id INTEGER,
      FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
    );
''');

  db.dispose();
  

}
}
