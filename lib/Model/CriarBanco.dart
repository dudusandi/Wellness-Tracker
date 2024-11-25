import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

class CriarBanco {
  Future<void> criarBancoDeDados() async {
    late String path;

    if (Platform.isIOS || Platform.isAndroid) {
      final directory = await getApplicationDocumentsDirectory();
      path = '${directory.path}/banco.db';
    } else if (Platform.isWindows) {
      final directory =
          Directory('${Platform.environment['USERPROFILE']}\\Documents');
      path = '${directory.path}\\banco.db';
    } else if (Platform.isMacOS) {
      final directory = Directory('${Platform.environment['HOME']}/Documents');
      path = '${directory.path}/banco.db';
    } else {
      throw UnsupportedError("Plataforma não suportada");
    }

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
