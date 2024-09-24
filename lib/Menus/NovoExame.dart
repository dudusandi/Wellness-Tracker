import 'package:flutter/material.dart';

class NovoExame extends StatefulWidget {
  @override
  _NovoExameState createState() => _NovoExameState();
}

class _NovoExameState extends State<NovoExame> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Novo Exame Content', style: TextStyle(color: Colors.black, fontSize: 24)),
    );
  }
}