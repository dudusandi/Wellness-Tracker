import 'package:flutter/material.dart';

class Calendario extends StatefulWidget {
  @override
  _CalendarioState createState() => _CalendarioState();
}

class  _CalendarioState extends State<Calendario> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Calendário', style: TextStyle(color: Colors.black, fontSize: 24)),
    );
  }
}