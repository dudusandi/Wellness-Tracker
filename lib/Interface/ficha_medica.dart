import 'package:wellness_tracker/Controlador/Controller.dart';
import 'package:wellness_tracker/Model/GerenciarBanco.dart';
import 'package:wellness_tracker/Model/Usuario.dart';
import 'package:wellness_tracker/Model/UsuarioLogado.dart';
import 'package:flutter/material.dart';

class FichaMedica extends StatefulWidget {
  final Usuario usuario;

  FichaMedica({required this.usuario});

  @override
  _FichaMedicaState createState() => _FichaMedicaState();
}

class _FichaMedicaState extends State<FichaMedica> {
  final int? usuarioId = UsuarioLogado.usuario?.id;
  late Controller funcoes;
  late TextEditingController nomeController;
  late TextEditingController idadeController;
  TextEditingController comorbidades = TextEditingController();
  TextEditingController medicacoes = TextEditingController();
 bool isSwitched = true;
  double frequenciaExercicio = 0;

  int calcularIdade(String dataNascimento) {
    try {
      List<String> partes = dataNascimento.split('/');
      if (partes.length != 3) {
        throw const FormatException('Formato de data inválido');
      }
      String dataFormatada = "${partes[2]}-${partes[1]}-${partes[0]}";
      DateTime nascimento = DateTime.parse(dataFormatada);
      DateTime hoje = DateTime.now();
      int idade = hoje.year - nascimento.year;
      if (hoje.month < nascimento.month ||
          (hoje.month == nascimento.month && hoje.day < nascimento.day)) {
        idade--;
      }
      return idade;
    } catch (e) {
      return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    funcoes = Controller(GerenciarBanco());
    nomeController = TextEditingController(text: widget.usuario.nome);
    int idade = calcularIdade(widget.usuario.dataNascimento);
    idadeController = TextEditingController(text: idade.toString());
    frequenciaExercicio = widget.usuario.frequenciaExercicio!;
    comorbidades = TextEditingController(text: widget.usuario.comorbidades);
    medicacoes = TextEditingController(text: widget.usuario.medicacoes);
    isSwitched = widget.usuario.isSwitched ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF472B2B),
      padding: const EdgeInsets.all(60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ficha Médica',
            style: TextStyle(
                color: Colors.white, fontSize: 32, fontFamily: 'JuliusSansOne'),
          ),
          const SizedBox(height: 80),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white),
            child: TextField(
              controller: nomeController,
              style: const TextStyle(),
              decoration:
                  const InputDecoration(labelText: "Nome", border: InputBorder.none),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white),
                  child: TextField(
                    controller: idadeController,
                    style: const TextStyle(),
                    decoration: const InputDecoration(
                        labelText: "Idade", border: InputBorder.none),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Atividade Física',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Slider(
                    value: frequenciaExercicio,
                    min: 0,
                    max: 7,
                    divisions: 7,
                    label: frequenciaExercicio.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        frequenciaExercicio = value;
                      });
                    },
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey,
                  ),
                  const Text(
                    'Indique a quantidade de vezes por semana que se exercita',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ],
              ))
            ],
          ),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white),
            child: TextField(
              controller: comorbidades,
              style: const TextStyle(),
              decoration: const InputDecoration(
                  labelText: "Comorbidades", border: InputBorder.none),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 20),
                child: Text(
                  "Medicação Continua",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
                activeColor: const Color.fromARGB(255, 255, 255, 255),
                activeTrackColor: const Color.fromARGB(255, 53, 204, 48),
                inactiveThumbColor: Colors.grey,
                inactiveTrackColor: const Color.fromARGB(255, 255, 255, 255),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: medicacoes,
                    decoration: const InputDecoration(
                      labelText: "Nome das Medicações",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            style:ElevatedButton.styleFrom(backgroundColor: const Color(0xFFBE6161,),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),fixedSize: const Size(150, 40)),
            onPressed: () {
              int isMedicacaoContinua = isSwitched ? 1 : 0;
              setState(() {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Ficha Médica Atualizada!")),
                );
                widget.usuario.medicacoes = medicacoes.text;
                widget.usuario.comorbidades = comorbidades.text;
                widget.usuario.frequenciaExercicio = frequenciaExercicio;
                widget.usuario.isSwitched = isSwitched;
              });
              funcoes.salvarFichaMedica(usuarioId!, frequenciaExercicio,
                  comorbidades.text, medicacoes.text, isMedicacaoContinua);
            },
            child: const Text("Salvar", style: TextStyle(color: Colors.white),),
          )
        ],
      ),
    );
  }
}
