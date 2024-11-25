import 'package:wellness_tracker/Controlador/Controller.dart';
import 'package:wellness_tracker/Interface/Login.dart';
import 'package:wellness_tracker/Model/Exame.dart';
import 'package:wellness_tracker/Model/GerenciarBanco.dart';
import 'package:wellness_tracker/Model/Usuario.dart';
import 'package:wellness_tracker/Model/UsuarioLogado.dart';
import 'package:flutter/material.dart';

class PaginaInicial extends StatefulWidget {

  final Usuario usuario; 
  PaginaInicial({Key? key, required this.usuario}) : super(key: key);
  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {

    @override
  void initState() {
    super.initState();
    _controller = Controller(_gerenciarBanco);
    _carregar();
  }

  final GerenciarBanco _gerenciarBanco = GerenciarBanco();
  Controller? _controller; 
  List<Exame> _exames = [];
  String _resumoHemograma = 'Carregando...'; 
  String _resumoPerfilLipidico = 'Carregando...'; 
  String _resumoTireoide = 'Carregando...'; 
  String  _resumoGlicemia= 'Carregando...'; 
  String _resumoCompleto= 'Carregando...'; 

Future<void> _carregar() async {
  int? usuarioID = UsuarioLogado.usuario?.id;
  if (usuarioID != null) {
    List<Exame> exames = await _controller!.carregarDataUltimoExame(usuarioID);
    String resumoPerfilLipidico = await _controller!.obterResumoPerfilLipidico(usuarioID); 
    String resumoTireoide = await _controller!.obterResumoTireoideSimples(usuarioID); 
    String resumoGlicemia = await _controller!.obterResumoGlicemiaSimples(usuarioID); 
    String resumoCompleto = await _controller!.obterResumoCompleto(usuarioID); 
    String resumoHemograma = await _controller!.obterResumoHemograma(usuarioID); 
    setState(() {
      _exames = exames;
      _resumoPerfilLipidico = resumoPerfilLipidico; 
      _resumoTireoide = resumoTireoide;
      _resumoGlicemia = resumoGlicemia;
      _resumoCompleto = resumoCompleto;
      _resumoHemograma = resumoHemograma;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF472B2B),
      padding: EdgeInsets.only(top: 50, bottom: 20, left: 50, right: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  'Bem Vindo, ${widget.usuario.nome}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontFamily: 'JuliusSansOne'),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Text(
                    "Sair da Conta",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 156, 96, 91),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 80),
          Text('Dados Recentes',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'JuliusSansOne',
                  fontSize: 16)),
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Card(
                  color: Color(0xFF351A1A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40, left: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.favorite, color: Colors.red, size: 80),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 60),
                                child: Center(
                                  child: Text(
                                    _resumoCompleto,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontFamily: 'JuliusSansOne',
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            'Resumo sobre sua Saúde',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                              fontFamily: 'JuliusSansOne',
                            ),
                          ),
                        ),
                        SizedBox(height: 10)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Card(
                  color: Color(0xFF351A1A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40, left: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_month,
                                color: Colors.lightBlueAccent, size: 80),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 60),
                                child: Center(
                                  child: Text(
                                     _exames.isNotEmpty? _exames.first.dataExame: 'Não Disponivel',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontFamily: 'JuliusSansOne',
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            'Data do Último Exame',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                              fontFamily: 'JuliusSansOne',
                            ),
                          ),
                        ),
                        SizedBox(height: 10)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text('Resumo Médico',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'JuliusSansOne',
                  fontSize: 16)),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              width: 3000,
              height: 3000,
              padding: EdgeInsets.only(top: 10, right: 30, left: 30, bottom: 10),
              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFF351A1A)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _resumoHemograma,
                    style: TextStyle(
                      color: Color(0xffF6F6F6),
                    ),
                  ),
                  Text(
                    _resumoPerfilLipidico,
                    style: TextStyle(
                      color: Color(0xffF6F6F6),
                    ),
                  ),
                  Text(
                    _resumoTireoide,
                    style: TextStyle(
                      color: Color(0xffF6F6F6),
                    ),
                  ),
                  Text(
                    _resumoGlicemia,
                    style: TextStyle(
                      color: Color(0xffF6F6F6),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
