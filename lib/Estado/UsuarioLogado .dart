import 'package:WelnessTracker/Model/Usuario.dart';

class UsuarioLogado {
  static Usuario? usuario; 

  static void setUsuario(Usuario usuarioLogado) {
    usuario = usuarioLogado; 
  }

  static void clearUsuario() {
    usuario = null; 
  }
}
