import 'package:flutter/material.dart';

class Academia extends StatefulWidget {
  @override
  _AcademiaState createState() => _AcademiaState();
}

class _AcademiaState extends State<Academia> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Academia', style: TextStyle(color: Colors.black, fontSize: 24)),
    );
  }
}