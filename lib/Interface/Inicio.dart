import 'package:WelnessTracker/Interface/login.dart';
import 'package:flutter/material.dart';
import '../Interface/calendario.dart';
import '../Interface/exames.dart';
import '../Interface/academia.dart';
import 'ficha_medica.dart';
import 'novo_exame.dart'; 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Inicio(usuario: {}), 
    );
  }
}

class Inicio extends StatefulWidget {
  final Map<String, dynamic> usuario; 

  Inicio({Key? key, Map<String, dynamic>? usuario}) 
    : usuario = usuario ?? {}, 
      super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  int _selectedIndex = 0;

  late List<Widget> _pages; 

  @override
  void initState() {
    super.initState();
    _pages = [
      MainContent(usuario: widget.usuario), 
      Exames(),
      FichaMedica(),
      NovoExame(),
      Calendario(),
      Academia(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 280,
            color: Color(0xFFBE6161),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Text(
                    'WELLNESS TRACKER',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'JuliusSansOne',
                    ),
                  ),
                  SizedBox(height: 60),
                  _buildMenuItem(Icons.home, 'Principal', 0),
                  SizedBox(height: 30),
                  _buildMenuItem(Icons.add, 'Novo Exame', 3),
                  SizedBox(height: 30),
                  _buildMenuItem(Icons.assignment, 'Ver Exames', 1),
                  SizedBox(height: 30),
                  _buildMenuItem(Icons.favorite, 'Ficha Médica', 2),
                  SizedBox(height: 30),
                  _buildMenuItem(Icons.calendar_today, 'Calendário', 4),
                  SizedBox(height: 30),
                  _buildMenuItem(Icons.fitness_center, 'Academia', 5),
                ],
              ),
            ),
          ),
          Expanded(
            child: _pages[_selectedIndex], 
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white, fontFamily: 'JuliusSansOne', fontSize: 20)),
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }
}

class MainContent extends StatelessWidget {
  final Map<String, dynamic> usuario; 
  MainContent({Key? key, required this.usuario}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF472B2B),
      padding: EdgeInsets.all(60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  'Bem Vindo, ${usuario['nome'] ?? 'Usuário'}!',
                  style: TextStyle(color: Colors.white, fontSize: 32, fontFamily: 'JuliusSansOne'),
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
                    style: TextStyle(color: const Color.fromARGB(255, 156, 96, 91), fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 80),
          Text('Dados Recentes', style: TextStyle(color: Colors.white, fontFamily: 'JuliusSansOne', fontSize: 16)),
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
                                    'Não Disponivel', 
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
                            'NÃO DISPONIVEL',
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
                            Icon(Icons.calendar_month, color: Colors.lightBlueAccent, size: 80),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 60),
                                child: Center(
                                  child: Text(
                                    'Próxima Consulta',
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
                            'NÃO DISPONIVEL',
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
          SizedBox(height: 40),
          Text('Informações Gerais', style: TextStyle(color: Colors.white, fontFamily: 'JuliusSansOne', fontSize: 16)),
          SizedBox(height: 40),
          Card(
            color: Color(0xFF351A1A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              ),
            ),
          )
        ],
      ),
    );
  }
}
