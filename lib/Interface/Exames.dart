import 'package:flutter/material.dart';

class Exames extends StatefulWidget {
  @override
  _ExamesState createState() => _ExamesState();
}

class _ExamesState extends State<Exames> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF472B2B),
      padding: EdgeInsets.all(60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ver Exames',
            style: TextStyle(
                color: Colors.white, fontSize: 32, fontFamily: 'JuliusSansOne'),
          ),
          SizedBox(height: 80),
        ],
      ),
    );
  }
}
