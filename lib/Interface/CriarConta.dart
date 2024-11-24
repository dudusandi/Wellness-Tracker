import 'package:WelnessTracker/Controlador/Controller.dart';
import 'package:WelnessTracker/Interface/Login.dart';
import 'package:WelnessTracker/Model/GerenciarBanco.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
  final Controller funcoes = Controller(GerenciarBanco());
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _dataNascimentoController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  var maskFormatter = MaskTextInputFormatter(
    mask: "##/##/####",
  );

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
                      labelText: "Nome", border: InputBorder.none),
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
                  inputFormatters: [maskFormatter],
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
                          try {
                            await funcoes.adicionarUsuario(
                              _nomeController.text,
                              _dataNascimentoController.text,
                              _emailController.text,
                              _senhaController.text,
                            );
                            _nomeController.clear();
                            _dataNascimentoController.clear();
                            _emailController.clear();
                            _senhaController.clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text("Conta criada com Sucesso!")),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text("Erro ao criar conta:  Usuário já está cadastrado no Sistema!")),
                            );
                          }
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
