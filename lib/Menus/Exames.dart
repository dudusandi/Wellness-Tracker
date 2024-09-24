import 'package:flutter/material.dart';

class Exames extends StatefulWidget {
  @override
  _ExamesState createState() => _ExamesState();
}

class _ExamesState extends State<Exames> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Exames', style: TextStyle(color: Colors.black, fontSize: 24)),
    );
  }
}