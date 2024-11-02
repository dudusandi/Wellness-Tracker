import 'package:WelnessTracker/Interface/Menu.dart';
import 'package:WelnessTracker/Interface/CriarConta.dart';
import 'package:WelnessTracker/Model/CriarBanco.dart';
import 'package:WelnessTracker/Model/GerenciarBanco.dart';
import 'package:WelnessTracker/Model/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import '../Model/UsuarioLogado.dart';

CriarBanco _criarBanco = CriarBanco();
GerenciarBanco _gerenciarBanco = GerenciarBanco();
void main() async{
  
    WidgetsFlutterBinding.ensureInitialized();
     await windowManager.ensureInitialized();

    WindowOptions windowOptions = WindowOptions(
    size: Size(1280, 800),
    minimumSize: Size(1280, 800),
    center: true,
    title: "WelnessTracker",
    windowButtonVisibility: true,
    titleBarStyle: TitleBarStyle.normal,
    );

     windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    });

  runApp(MyApp());
  _criarBanco.criarBancoDeDados();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginSenhaController = TextEditingController();

  final int? usuarioId = UsuarioLogado.usuario?.id;

 Future<void> _realizarLogin() async {
  String email = _loginEmailController.text;
  String senha = _loginSenhaController.text;

  bool sucesso = await _gerenciarBanco.logar(email, senha);

  if (sucesso) {
    var usuarioDados = await _gerenciarBanco.obterUsuarioPorEmail(email);
    if (usuarioDados != null) {
      Usuario usuario = Usuario(
        id: usuarioDados.id, 
        nome: usuarioDados.nome,
        dataNascimento: usuarioDados.dataNascimento,
        email: usuarioDados.email,
        senha: senha, 
      );
      UsuarioLogado.setUsuario(usuario); 
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Inicio(usuario: usuario)),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Email ou senha incorretos")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF472B2B),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'WELLNESS TRACKER',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'JuliusSansOne',
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Container(
              width: 300,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white),
              child: TextField(
                onSubmitted: (value) {
                  _realizarLogin();
                },
                style: TextStyle(),
                controller: _loginEmailController,
                decoration: InputDecoration(
                    labelText: "Email", border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white),
              child: TextField(
                obscureText: true,
                onSubmitted: (value) {
                  _realizarLogin();
                },
                style: TextStyle(),
                controller: _loginSenhaController,
                decoration: InputDecoration(
                    labelText: "Senha", border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  _realizarLogin();
                },
                child: Text("Entrar")),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginCadastro()),
                );
              },
              child: Text(
                "Não tem conta? Cadastre-se!",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}