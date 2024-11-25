import 'package:welness_tracker/Controlador/Controller.dart';
import 'package:welness_tracker/Model/GerenciarBanco.dart';
import 'package:welness_tracker/Model/UsuarioLogado.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
    ExameSangue(nome: 'Hemacias', unidade: 'mm³', valorMin: 39, valorMax: 50),
    ExameSangue(
        nome: 'Leucócitos', unidade: 'un', valorMin: 3500, valorMax: 10500),
    ExameSangue(
        nome: 'Plaquetas', unidade: 'mil/mm³', valorMin: 150, valorMax: 450),
    ExameSangue(nome: 'Glicose', unidade: 'mg/dL', valorMin: 70, valorMax: 100),
    ExameSangue(
        nome: 'Colesterol Total', unidade: 'mg/dL', valorMin: 0, valorMax: 190),
    ExameSangue(
        nome: 'Colesterol HDL', unidade: 'mg/dL', valorMin: 40, valorMax: 190),
    ExameSangue(
        nome: 'Colesterol LDL', unidade: 'mg/dL', valorMin: 0, valorMax: 130),
    ExameSangue(
        nome: 'Triglicérideos', unidade: 'mg/dL', valorMin: 0, valorMax: 150),
    ExameSangue(
        nome: 'T4 Livre', unidade: 'ng/dL', valorMin: 0.8, valorMax: 1.8),
    ExameSangue(nome: 'TSH', unidade: 'µU/mL', valorMin: 0.4, valorMax: 4.0),
  ];
}

class NovoExame extends StatefulWidget {
  @override
  _NovoExameState createState() => _NovoExameState();
}

class _NovoExameState extends State<NovoExame> {
  late Controller funcoes;

  @override
  void initState() {
    super.initState();
    funcoes = Controller(GerenciarBanco());
  }

  var maskFormatter = MaskTextInputFormatter(
    mask: "##/##/####",
  );

  final int? usuarioId = UsuarioLogado.usuario?.id;
  ExameSangue? _exameSelecionado;
  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();

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
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: DropdownButton<ExameSangue>(
                      hint: Text('Selecione o Exame'),
                      value: _exameSelecionado,
                      padding: EdgeInsets.only(left: 10, right: 10),
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
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: _valorController,
                      decoration: InputDecoration(
                        labelText: _exameSelecionado != null
                            ? _exameSelecionado!.unidade
                            : 'Insira o valor do exame',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 40),
            Container(
                width: 300,
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: _dataController,
                  inputFormatters: [maskFormatter],
                  decoration: InputDecoration(labelText: "Data do Exame"),
                )),
            SizedBox(height: 40),
            ElevatedButton(
              style:ElevatedButton.styleFrom(backgroundColor: Color(0xFFBE6161,),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),fixedSize: Size(200, 50),),
              onPressed: () => {
                if (_exameSelecionado != null && usuarioId != null)
                  {
                    funcoes.criarExame(
                      _exameSelecionado!.nome,
                      _dataController.text,
                      _valorController.text,
                      usuarioId!,
                    )
                  },
                setState(() {
                  _exameSelecionado = null;
                }),
                _dataController.clear(),
                _valorController.clear(),
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Exame Cadastrado com Sucesso")),
                )
              },
              child: Text('Adicionar Exame', style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
