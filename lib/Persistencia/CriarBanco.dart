import 'package:sqlite3/sqlite3.dart';
import 'dart:ffi';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';


Future<void> main() async {

  DynamicLibrary.open('assets/sqlite3.dll');
  final directory = await getApplicationDocumentsDirectory();
  final dbPath = join(directory.path, 'WellnessTrackerDatabase.db');
  final Database db = sqlite3.open(dbPath);

  db.execute('''
    CREATE TABLE IF NOT EXISTS test (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL
    )
  ''');

  db.execute('INSERT INTO test (name) VALUES (?)', ['Sample Name']);

  final ResultSet resultSet = db.select('SELECT * FROM test');
  for (final Row row in resultSet) {
    print('ID: ${row['id']}, Name: ${row['name']}');
  }

  db.dispose();
  

}

class Criarbanco {


}

