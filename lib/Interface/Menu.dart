import 'package:WelnessTracker/Interface/Ajuda.dart';
import 'package:WelnessTracker/Interface/Login.dart';
import 'package:WelnessTracker/Interface/PaginaInicial.dart';
import 'package:WelnessTracker/Model/Usuario.dart';
import 'package:flutter/material.dart';
import '../Interface/exames.dart';
import 'ficha_medica.dart';
import 'NovoExame.dart';

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
      PaginaInicial(usuario: widget.usuario),
      Exames(),
      FichaMedica(usuario: widget.usuario),
      NovoExame(),
      Ajuda(),
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
                  _buildMenuItem(Icons.help, 'Ajuda', 4),
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
    final bool isSelected = _selectedIndex == index;

    return ListTile(
      leading: Icon(icon, color: isSelected ? Color.fromARGB(255, 39, 32, 32) : Colors.white,),
      title: Text(title,
          style: TextStyle(
              color: isSelected ? Color.fromARGB(255, 39, 32, 32) : Colors.white, fontFamily: 'JuliusSansOne', fontSize: 20)),
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }
}
