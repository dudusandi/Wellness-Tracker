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

class NovoExame extends StatefulWidget {
  final List<ExameSangue> examesPredefinidos;

  NovoExame({required this.examesPredefinidos, required List exames});

  @override
  _NovoExameState createState() => _NovoExameState();
}

class _NovoExameState extends State<NovoExame> {
  ExameSangue? _exameSelecionado;
  final TextEditingController _valorController = TextEditingController();

  void _adicionarExame() {
    final double valorInserido = double.tryParse(_valorController.text) ?? 0.0;

    if (_exameSelecionado != null && valorInserido > 0) {
     
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Exame "${_exameSelecionado!.nome}" com valor $valorInserido adicionado!')),
      );

      _valorController.clear();
      setState(() {
        _exameSelecionado = null; 
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
              items: widget.examesPredefinidos.map((ExameSangue exame) {
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
