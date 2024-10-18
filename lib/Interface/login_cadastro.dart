import 'package:beta1/Interface/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

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
                        onPressed: () {
                          print("Criar Conta");
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
                            MaterialPageRoute(
                                builder: (context) => Login()),
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
