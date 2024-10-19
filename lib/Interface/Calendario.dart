import 'package:flutter/material.dart';

class Calendario extends StatefulWidget {
  @override
  _CalendarioState createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFF472B2B),
        padding: EdgeInsets.all(60),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Calendario',
            style: TextStyle(
                color: Colors.white, fontSize: 32, fontFamily: 'JuliusSansOne'),
          ),
          SizedBox(height: 80),
        ]));
  }
}
