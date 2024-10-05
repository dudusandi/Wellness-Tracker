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
  ExameSangue(nome: 'Hemoglobina', unidade: 'milhões/µL', valorMin: 13.5, valorMax: 17.5),
  ExameSangue(nome: 'Eritrócitos', unidade: 'g/dL', valorMin: 4.3, valorMax: 5.7),
  ExameSangue(nome: 'Hematócrito', unidade: '%', valorMin: 39, valorMax: 50),
  ExameSangue(nome: 'H.C.M.', unidade: 'pg', valorMin: 26, valorMax: 34),
  ExameSangue(nome: 'V.C.M', unidade: 'fL', valorMin: 80, valorMax: 99),
  ExameSangue(nome: 'C.H.C.M', unidade: 'g/dL', valorMin: 31, valorMax: 36),
  ExameSangue(nome: 'R.D.W', unidade: '', valorMin: 12, valorMax: 14.9),
  ExameSangue(nome: 'Leucócitos', unidade: 'un', valorMin: 3500, valorMax: 10500),
  ExameSangue(nome: 'Neutrófilos', unidade: 'un', valorMin: 1700, valorMax: 8000),
  ExameSangue(nome: 'Linfócitos', unidade: 'un', valorMin: 900, valorMax: 2900),
  ExameSangue(nome: 'Monócitos', unidade: 'un', valorMin: 300, valorMax: 900),
  ExameSangue(nome: 'Eosinófilos', unidade: 'un', valorMin: 50, valorMax: 500),
  ExameSangue(nome: 'Basófilos', unidade: 'un', valorMin: 0, valorMax: 100),
  ExameSangue(nome: 'Plaquetas', unidade: 'mil/mm³', valorMin: 150, valorMax: 450),
  ExameSangue(nome: 'Glicose', unidade: 'mg/dL', valorMin: 70, valorMax: 100),
  ExameSangue(nome: 'Colesterol Total', unidade: 'mg/dL', valorMin: 0, valorMax: 190),
  ExameSangue(nome: 'Colesterol HDL', unidade: 'mg/dL', valorMin: 40, valorMax: 190),
  ExameSangue(nome: 'Colesterol não HDL', unidade: 'mg/dL', valorMin: 0, valorMax: 160),
  ExameSangue(nome: 'Colesterol LDL', unidade: 'mg/dL', valorMin: 0, valorMax: 130),
  ExameSangue(nome: 'Triglicérides', unidade: 'mg/dL', valorMin: 0, valorMax: 150),
  ];
}

class NovoExame extends StatefulWidget {
  @override
  _NovoExameState createState() => _NovoExameState();
}

class _NovoExameState extends State<NovoExame> {
  ExameSangue? _exameSelecionado;
  final TextEditingController _valorController = TextEditingController();

  void _adicionarExame() {
    final double valorInserido = double.tryParse(_valorController.text) ?? 0.0;

    if (_exameSelecionado != null && valorInserido > 0) {
      // Adicione a lógica aqui para salvar o valor do exame selecionado
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Exame "${_exameSelecionado!.nome}" com valor $valorInserido adicionado!')),
      );

      // Limpar o campo de valor após adicionar
      _valorController.clear();
      setState(() {
        _exameSelecionado = null; // Resetar o exame selecionado
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selecione um exame e insira um valor válido!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Novo Exame'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<ExameSangue>(
              hint: Text('Selecione o Exame'),
              value: _exameSelecionado,
              isExpanded: true,
              items: ExameSangue.examesPredefinidos.map((ExameSangue exame) {
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
            if (_exameSelecionado != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'Unidade: ${_exameSelecionado!.unidade}\n'
                  'Valor de Referência: ${_exameSelecionado!.valorMin} - ${_exameSelecionado!.valorMax} ${_exameSelecionado!.unidade}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            SizedBox(height: 20),
            TextField(
              controller: _valorController,
              decoration: InputDecoration(labelText: 'Insira o valor do exame'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _adicionarExame,
              child: Text('Adicionar Exame'),
            ),
          ],
        ),
      ),
    );
  }
}