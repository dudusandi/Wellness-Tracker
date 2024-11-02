import 'package:WelnessTracker/Interface/main.dart';
import 'package:WelnessTracker/Interface/main_content.dart';
import 'package:WelnessTracker/Model/Usuario.dart';
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
      home: Login(),
    );
  }
}

class Inicio extends StatefulWidget {
  final Usuario usuario; 
  Inicio({Key? key, required this.usuario}) : super(key: key);



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
      MainContent(usuario: widget.usuario,),
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
