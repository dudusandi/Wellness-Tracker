import 'package:WelnessTracker/Interface/login.dart';
import 'package:WelnessTracker/Persistencia/GerenciarBanco.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginCadastro(),
    );
  }
}

class LoginCadastro extends StatefulWidget {
  @override
  _LoginCadastroState createState() => _LoginCadastroState();
}

class _LoginCadastroState extends State<LoginCadastro> {

  final GerenciarBanco _gerenciarBanco = GerenciarBanco();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _dataNascimentoController =TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF472B2B),
      body: Center(
        child: Container(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'CRIAR NOVA CONTA',
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
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: TextField(
                  controller: _nomeController,
                  style: TextStyle(),
                  decoration: InputDecoration(
                      labelText: "Nome", 
                      border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: TextField(
                  controller: _dataNascimentoController,
                  style: TextStyle(),
                  decoration: InputDecoration(
                      labelText: "Data de Nascimento",
                      border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: TextField(
                  controller: _emailController,
                  style: TextStyle(),
                  decoration: InputDecoration(
                      labelText: "Email", border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: TextField(
                  controller: _senhaController,
                  style: TextStyle(),
                  decoration: InputDecoration(
                      labelText: "Senha", border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () async {
                          await _gerenciarBanco.criarUsuario(
                          _nomeController.text,
                          _dataNascimentoController.text,
                          _emailController.text,
                          _senhaController.text,
                        );
                        _nomeController.clear();
                        _dataNascimentoController.clear();
                        _emailController.clear();
                        _senhaController.clear();
                        },
                        child: Text("Criar Conta")),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Text("Voltar ao Inicio")),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
