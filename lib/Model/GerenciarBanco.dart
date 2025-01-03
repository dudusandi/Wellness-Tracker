import 'dart:io';

import 'package:wellness_tracker/Model/Exame.dart';
import 'package:wellness_tracker/Model/Usuario.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'dart:async';

class GerenciarBanco {

  Future<String> obterCaminhoBanco() async {
    late String path;

    if (Platform.isIOS || Platform.isAndroid) {
      final directory = await getApplicationDocumentsDirectory();
      path = '${directory.path}/WTBanco.db';
    } else if (Platform.isWindows) {
      final directory =
          Directory('${Platform.environment['USERPROFILE']}\\Documents');
      path = '${directory.path}\\WTBanco.db';
    } else if (Platform.isMacOS) {
      final directory = Directory('${Platform.environment['HOME']}/Documents');
      path = '${directory.path}/WTBanco.db';
    } else {
      throw UnsupportedError("Plataforma não suportada");
    }

    return path;
  }

    Future<Database> _abrirBanco() async {
    final path = await obterCaminhoBanco();
    return sqlite3.open(path);
  }


  Future<void> criarUsuario(Usuario usuario) async {
    final db = await _abrirBanco();

    db.execute(
        'INSERT INTO usuarios (nome, data_nascimento, email, senha) VALUES (?, ?, ?, ?)',
        [usuario.nome, usuario.dataNascimento, usuario.email, usuario.senha]);
    db.dispose();
  }

  Future<void> salvarFichaMedica(int id, double frequenciaExercicio,
      String comorbidades, String medicacoes, int isSwitched) async {
  
      final db = await _abrirBanco();

    db.execute(
        'UPDATE usuarios SET frequencia_exercicio = ?, comorbidades = ?, medicacoes = ?,  is_medicacao_continua= ? WHERE id = ?',
        [
          frequenciaExercicio,
          comorbidades,
          medicacoes,
          isSwitched,
          id,
        ]);

    db.dispose();
  }

  Future<void> criarExame(Exame exame, int usuarioID) async {
        final db = await _abrirBanco();

    db.execute(
        'INSERT INTO exames (nome, data_exame, valor, usuario_id) VALUES (?, ?, ?, ?)',
        [exame.nome, exame.dataExame, exame.valor, exame.usuarioId]);
    db.dispose();
  }

  Future<bool> logar(String email, String senha) async {

        final db = await _abrirBanco();

    final ResultSet result = db.select(
      'SELECT * FROM usuarios WHERE email = ? AND senha = ?',
      [email, senha],
    );

    db.dispose();

    return result.isNotEmpty;
  }

  Future<Usuario?> obterUsuarioPorEmail(String email) async {
    final db = await _abrirBanco();

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
        frequenciaExercicio:
            double.tryParse(usuarioData['frequencia_exercicio'].toString()) ??
                0,
        comorbidades: usuarioData['comorbidades'],
        medicacoes: usuarioData['medicacoes'],
        isSwitched: usuarioData['is_medicacao_continua'] == 'true' ||
            usuarioData['is_medicacao_continua'] == '1',
      );
    }

    return null;
  }

  Future<List<Exame>> obterExamesPorUsuarioId(int usuarioId) async {
    final db = await _abrirBanco();

    final result = db.select(
      'SELECT * FROM exames WHERE usuario_id = ?',
      [usuarioId],
    );

    db.dispose();

    return result
        .map((exameData) => Exame(
              id: exameData['id'],
              nome: exameData['nome'],
              dataExame: exameData['data_exame'],
              valor: exameData['valor'],
              usuarioId: usuarioId,
            ))
        .toList();
  }

  Future<double?> obterValorExame(int usuarioId, String nomeExame) async {
     final db = await _abrirBanco();


    final result = db.select(
      'SELECT valor FROM exames WHERE usuario_id = ? AND nome = ? ORDER BY data_exame DESC LIMIT 1',
      [usuarioId, nomeExame],
    );

    db.dispose();

    if (result.isNotEmpty) {
      return double.tryParse(result.first['valor'].toString());
    }
    return null;
  }

  Future<void> removerExamePorId(int exameId) async {
  
   final db = await _abrirBanco();


    db.execute(
      'DELETE FROM exames WHERE id = ?',
      [exameId],
    );
    db.dispose();
  }
}
