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

  static List<ExameSangue> examesPredefinidos = [
    ExameSangue(
        nome: 'Hemoglobina',
        unidade: 'milhões/µL',
        valorMin: 13.5,
        valorMax: 17.5),
    ExameSangue(
        nome: 'Eritrócitos', unidade: 'g/dL', valorMin: 4.3, valorMax: 5.7),
    ExameSangue(nome: 'Hematócrito', unidade: '%', valorMin: 39, valorMax: 50),
    ExameSangue(nome: 'H.C.M.', unidade: 'pg', valorMin: 26, valorMax: 34),
    ExameSangue(nome: 'V.C.M', unidade: 'fL', valorMin: 80, valorMax: 99),
    ExameSangue(nome: 'C.H.C.M', unidade: 'g/dL', valorMin: 31, valorMax: 36),
    ExameSangue(nome: 'R.D.W', unidade: '', valorMin: 12, valorMax: 14.9),
    ExameSangue(
        nome: 'Leucócitos', unidade: 'un', valorMin: 3500, valorMax: 10500),
    ExameSangue(
        nome: 'Neutrófilos', unidade: 'un', valorMin: 1700, valorMax: 8000),
    ExameSangue(
        nome: 'Linfócitos', unidade: 'un', valorMin: 900, valorMax: 2900),
    ExameSangue(nome: 'Monócitos', unidade: 'un', valorMin: 300, valorMax: 900),
    ExameSangue(
        nome: 'Eosinófilos', unidade: 'un', valorMin: 50, valorMax: 500),
    ExameSangue(nome: 'Basófilos', unidade: 'un', valorMin: 0, valorMax: 100),
    ExameSangue(
        nome: 'Plaquetas', unidade: 'mil/mm³', valorMin: 150, valorMax: 450),
    ExameSangue(nome: 'Glicose', unidade: 'mg/dL', valorMin: 70, valorMax: 100),
    ExameSangue(
        nome: 'Colesterol Total', unidade: 'mg/dL', valorMin: 0, valorMax: 190),
    ExameSangue(
        nome: 'Colesterol HDL', unidade: 'mg/dL', valorMin: 40, valorMax: 190),
    ExameSangue(
        nome: 'Colesterol não HDL',
        unidade: 'mg/dL',
        valorMin: 0,
        valorMax: 160),
    ExameSangue(
        nome: 'Colesterol LDL', unidade: 'mg/dL', valorMin: 0, valorMax: 130),
    ExameSangue(
        nome: 'Triglicérides', unidade: 'mg/dL', valorMin: 0, valorMax: 150),
  ];
}

class NovoExame extends StatefulWidget {
  @override
  _NovoExameState createState() => _NovoExameState();
}

class _NovoExameState extends State<NovoExame> {
  ExameSangue? _exameSelecionado;
  final TextEditingController _valorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF472B2B),
        padding: EdgeInsets.all(60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Novo Exame',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontFamily: 'JuliusSansOne'),
            ),
            SizedBox(height: 80),
            Text(
              'Selecione o tipo de exame, em seguida insira o valor na unidade de medida correta:',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'JuliusSansOne'),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                    child: DropdownButton<ExameSangue>(
                      hint: Text('Selecione o Exame'),
                      value: _exameSelecionado,
                      padding: EdgeInsets.only(left: 10,right: 10),
                      underline: SizedBox(),
                      isExpanded: true,
                      items: ExameSangue.examesPredefinidos
                          .map((ExameSangue exame) {
                        return DropdownMenuItem<ExameSangue>(
                          value: exame,
                          child: Text(exame.nome),
                        );
                      }).toList(),
                      onChanged: (ExameSangue? novoExameSelecionado) {
                        setState(() {
                          _exameSelecionado = novoExameSelecionado;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white, ),
                    child: TextField(
                    
                      controller: _valorController,
                      decoration:
                          InputDecoration(
                            labelText: _exameSelecionado != null
                            ? _exameSelecionado!.unidade
                            : 'Insira o valor do exame', ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => {print("Adicionar Exame")},
              child: Text('Adicionar Exame'),
            ),
          ],
        ),
      ),
    );
  }
}
