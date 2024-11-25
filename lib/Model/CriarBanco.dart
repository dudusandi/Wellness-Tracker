import 'package:WelnessTracker/Model/GerenciarBanco.dart';
import 'package:sqlite3/sqlite3.dart';

class CriarBanco {

   GerenciarBanco gerenciarBanco = GerenciarBanco();
  
  Future<void> criarBancoDeDados() async {
    
    final path = await gerenciarBanco.obterCaminhoBanco();

    final db = sqlite3.open(path);

    db.execute('''
    CREATE TABLE IF NOT EXISTS usuarios (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      data_nascimento TEXT NOT NULL,
      email TEXT NOT NULL UNIQUE,
      senha TEXT NOT NULL,
      frequencia_exercicio TEXT,
      comorbidades TEXT,
      medicacoes TEXT,
      is_medicacao_continua TEXT
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
