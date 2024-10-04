import 'package:flutter/material.dart';

class ExameSangue {
  String nome;
  String unidade;
  double valorMin;
  double valorMax;

  ExameSangue({
    required this.nome,
    required this.unidade,
    required this.valorMin,
    required this.valorMax,
  });
}

List<ExameSangue> exames = [
  ExameSangue(nome: 'Hemoglobina', unidade: 'g/dL', valorMin: 13.5, valorMax: 17.5),
  ExameSangue(nome: 'Glicose', unidade: 'mg/dL', valorMin: 70, valorMax: 100),
  ExameSangue(nome: 'Plaquetas', unidade: 'mil/mm³', valorMin: 150, valorMax: 450),
  ExameSangue(nome: 'Colesterol Total', unidade: 'mil/mm³', valorMin: 0, valorMax: 190),
  ExameSangue(nome: 'Colesterol HDL', unidade: 'mil/mm³', valorMin: 40, valorMax: 190),
  ExameSangue(nome: 'Colesterol não HDL', unidade: 'mil/mm³', valorMin: 0, valorMax: 160),
  ExameSangue(nome: 'Colesterol LDL', unidade: 'mil/mm³', valorMin: 0, valorMax: 130),
  ExameSangue(nome: 'Triglicérides', unidade: 'mg/dL', valorMin: 0, valorMax: 150),
];


class ListaExamesScreen extends StatelessWidget {
  final List<ExameSangue> exames;

  ListaExamesScreen({required this.exames});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parâmetros de Exames de Sangue'),
      ),
      body: ListView.builder(
        itemCount: exames.length,
        itemBuilder: (context, index) {
          final exame = exames[index];
          return ListTile(
            title: Text(exame.nome),
            subtitle: Text('Valor de Referência: ${exame.valorMin} - ${exame.valorMax} ${exame.unidade}'),
          );
        },
      ),
    );
  }
}
