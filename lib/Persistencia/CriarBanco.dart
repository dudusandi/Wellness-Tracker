import 'package:sqlite3/sqlite3.dart';
import 'dart:ffi';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

void main() async {
  await criarBancoDeDados();
}

Future<void> criarBancoDeDados() async {

  DynamicLibrary.open('assets/sqlite3.dll');

  final directory = await getApplicationDocumentsDirectory();
  final dbPath = join(directory.path, 'WellnessTrackerDatabase.db');
  final Database db = sqlite3.open(dbPath);

  db.execute('''
    CREATE TABLE IF NOT EXISTS usuarios (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      data_nascimento TEXT NOT NULL,
      email TEXT NOT NULL UNIQUE,
      senha TEXT NOT NULL
    )
  ''');

  db.dispose();
  

}

