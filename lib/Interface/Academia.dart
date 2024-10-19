import 'package:flutter/material.dart';

class Academia extends StatefulWidget {
  @override
  _AcademiaState createState() => _AcademiaState();
}

class _AcademiaState extends State<Academia> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFF472B2B),
        padding: EdgeInsets.all(60),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Academia',
            style: TextStyle(
                color: Colors.white, fontSize: 32, fontFamily: 'JuliusSansOne'),
          ),
          SizedBox(height: 80),
        ]));
  }
}