import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    MainContent(),
    ExamsContent(),
    MedicalRecordContent(),
    NewExamContent(),
    CalendarContent(),
    GymContent(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Menu Lateral
          Container(
            width: 280,
            color: Color(0xFFBE6161),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Text(
                    'HEALTH PLAN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'JuliusSansOne',
                    ),
                  ),
                  SizedBox(height: 60),
                  _buildMenuItem(Icons.home, 'Principal', 0),
                  SizedBox(height: 30),
                  _buildMenuItem(Icons.assignment, 'Ver Exames', 1),
                  SizedBox(height: 30),
                  _buildMenuItem(Icons.favorite, 'Ficha Médica', 2),
                  SizedBox(height: 30),
                  _buildMenuItem(Icons.add, 'Novo Exame', 3),
                  SizedBox(height: 30),
                  _buildMenuItem(Icons.calendar_today, 'Calendário', 4),
                  SizedBox(height: 30),
                  _buildMenuItem(Icons.fitness_center, 'Academia', 5),
                ],
              ),
            ),
          ),
          // Conteúdo Principal
          Expanded(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: _pages[_selectedIndex],
            ),
          ),
        ],
      ),
    );
  }

  // Widget para criar um item do menu
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

// Widgets Dinâmicos

class MainContent extends StatefulWidget {
  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF472B2B),
      padding: EdgeInsets.all(60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bem Vindo, Eduardo Sandi',
            style: TextStyle(color: Colors.white, fontSize: 32, fontFamily: 'JuliusSansOne'),
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
                                    'Glicose 92%',
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
                            'TAXA ACIMA DO NORMAL!',
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
                            'Oftalmologista na Sexta',
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
                children: [
                  // Primeira Coluna
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Batimentos',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '109 BPM',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                      Divider(color: Colors.white, thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Vitamina B',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '109 UI',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                      Divider(color: Colors.white, thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Vitamina D',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '509 UI',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                      Divider(color: Colors.white, thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Vitamina E',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '85 UI',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                  VerticalDivider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                  // Segunda Coluna
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Batimentos',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '109 BPM',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                      Divider(color: Colors.white, thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Vitamina B',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '109 UI',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                      Divider(color: Colors.white, thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Vitamina D',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '509 UI',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                      Divider(color: Colors.white, thickness: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Vitamina E',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '85 UI',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ],
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

class ExamsContent extends StatefulWidget {
  @override
  _ExamsContentState createState() => _ExamsContentState();
}

class _ExamsContentState extends State<ExamsContent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Exames Content', style: TextStyle(color: Colors.black, fontSize: 24)),
    );
  }
}

class MedicalRecordContent extends StatefulWidget {
  @override
  _MedicalRecordContentState createState() => _MedicalRecordContentState();
}

class _MedicalRecordContentState extends State<MedicalRecordContent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Ficha Médica Content', style: TextStyle(color: Colors.black, fontSize: 24)),
    );
  }
}

class NewExamContent extends StatefulWidget {
  @override
  _NewExamContentState createState() => _NewExamContentState();
}

class _NewExamContentState extends State<NewExamContent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Novo Exame Content', style: TextStyle(color: Colors.black, fontSize: 24)),
    );
  }
}

class CalendarContent extends StatefulWidget {
  @override
  _CalendarContentState createState() => _CalendarContentState();
}

class _CalendarContentState extends State<CalendarContent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Calendário Content', style: TextStyle(color: Colors.black, fontSize: 24)),
    );
  }
}

class GymContent extends StatefulWidget {
  @override
  _GymContentState createState() => _GymContentState();
}

class _GymContentState extends State<GymContent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Academia Content', style: TextStyle(color: Colors.black, fontSize: 24)),
    );
  }
}
