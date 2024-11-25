import 'package:wellness_tracker/Controlador/Controller.dart';
import 'package:wellness_tracker/Interface/Login.dart';
import 'package:wellness_tracker/Model/GerenciarBanco.dart';
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
      backgroundColor: const Color(0xFF472B2B),
      body: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'CRIAR NOVA CONTA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'JuliusSansOne',
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: TextField(
                  controller: _nomeController,
                  style: const TextStyle(),
                  decoration: const InputDecoration(
                      labelText: "Nome", border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: TextField(
                  controller: _dataNascimentoController,
                  inputFormatters: [maskFormatter],
                  style: const TextStyle(),
                  decoration: const InputDecoration(
                      labelText: "Data de Nascimento",
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: TextField(
                  controller: _emailController,
                  style: const TextStyle(),
                  decoration: const InputDecoration(
                      labelText: "Email", border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: TextField(
                  controller: _senhaController,
                  style: const TextStyle(),
                  decoration: const InputDecoration(
                      labelText: "Senha", border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style:ElevatedButton.styleFrom(backgroundColor: const Color(0xFFBE6161,),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
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
                              const SnackBar(
                                  content: Text("Conta criada com Sucesso!")),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Erro ao criar conta:  Usuário já está cadastrado no Sistema!")),
                            );
                          }
                        },
                        child: const Text("Criar Conta", style: TextStyle(color: Colors.white),)),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style:ElevatedButton.styleFrom(backgroundColor: const Color(0xFFBE6161,),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: const Text("Voltar ao Inicio",style: TextStyle(color: Colors.white),)),
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
