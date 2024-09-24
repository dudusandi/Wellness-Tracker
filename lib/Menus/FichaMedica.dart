import 'package:flutter/material.dart';

class FichaMedica extends StatefulWidget {
  @override
  _FichaMedicaState createState() => _FichaMedicaState();
}

class _FichaMedicaState extends State<FichaMedica> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Ficha Médica Content', style: TextStyle(color: Colors.black, fontSize: 24)),
    );
  }
}