import 'package:WelnessTracker/Interface/main.dart';
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
      title: Text(title,
          style: TextStyle(
              color: Colors.white, fontFamily: 'JuliusSansOne', fontSize: 20)),
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
      padding: EdgeInsets.only(top: 50, bottom: 20, left: 50, right: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  'Bem Vindo, ${usuario['nome'] ?? 'Usuário'}!',
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
                                    'Requer Atenção',
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
                            Icon(Icons.calendar_month,
                                color: Colors.lightBlueAccent, size: 80),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 60),
                                child: Center(
                                  child: Text(
                                    '25/04/2020',
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
                            'Data do Ultimo Exame',
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
              padding: EdgeInsets.only(top: 30, right: 30, left: 30, bottom: 5),
              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFF351A1A)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hemograma Completo: Dentro dos valores normais, indicando que não há sinais de anemia, infecções ou problemas de coagulação",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Perfil Lipídico: Todos os valores estão dentro das faixas recomendadas, apontando baixo risco para doenças cardiovasculares.",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Função Tireoidiana: TSH e T4 Livre normais, indicando que a tireoide está funcionando adequadamente.",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Glicemia em Jejum: Dentro do esperado, sugerindo controle adequado dos níveis de glicose no sangue.",
                    style: TextStyle(
                      color: Colors.white,
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
