import 'package:WelnessTracker/Interface/Inicio.dart';
import 'package:WelnessTracker/Interface/login_cadastro.dart';
import 'package:WelnessTracker/Persistencia/CriarBanco.dart';
import 'package:WelnessTracker/Persistencia/GerenciarBanco.dart';
import 'package:flutter/material.dart';

CriarBanco _criarBanco = CriarBanco();
GerenciarBanco _gerenciarBanco = GerenciarBanco();
void main() {
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

  Future<void> _realizarLogin() async {
    String email = _loginEmailController.text;
    String senha = _loginSenhaController.text;

    bool sucesso = await _gerenciarBanco.logar(email, senha);

    if (sucesso) {
      var usuario = await _gerenciarBanco.obterUsuarioPorEmail(email);
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Inicio(usuario: usuario)), 
      );
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
