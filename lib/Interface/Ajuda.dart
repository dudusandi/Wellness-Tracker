import 'package:flutter/material.dart';

class Ajuda extends StatefulWidget {
  @override
  _AjudaState createState() => _AjudaState();
}

class _AjudaState extends State<Ajuda> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFF472B2B),
        padding: EdgeInsets.all(60),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Ajuda',
            style: TextStyle(
                color: Colors.white, fontSize: 32, fontFamily: 'JuliusSansOne'),
          ),
          SizedBox(height: 80),
        ]));
  }
}