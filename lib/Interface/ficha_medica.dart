import 'package:WelnessTracker/Model/Usuario.dart';
import 'package:flutter/material.dart';

class FichaMedica extends StatefulWidget {
final Usuario usuario;

  FichaMedica({required this.usuario});


  @override
  _FichaMedicaState createState() => _FichaMedicaState();
}


class _FichaMedicaState extends State<FichaMedica> {
 
  late TextEditingController nomeController;
  late TextEditingController idadeController;

int calcularIdade(String dataNascimento) {
  try {
    List<String> partes = dataNascimento.split('/');
    if (partes.length != 3) {
      throw FormatException('Formato de data inválido');
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
    print("Erro ao calcular idade: $e");
    return 0; 
  }
}

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController(text: widget.usuario.nome);
    
    int idade = calcularIdade(widget.usuario.dataNascimento);

    idadeController = TextEditingController(text: idade.toString());
  }


  @override
  Widget build(BuildContext context) {
    bool isSwitched = true;
    double FrequenciaExercicio = 0; 

    return Container(
      color: Color(0xFF472B2B),
      padding: EdgeInsets.all(60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ficha Médica',
            style: TextStyle(
                color: Colors.white, fontSize: 32, fontFamily: 'JuliusSansOne'),
          ),
          SizedBox(height: 80),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white),
            child: TextField(
              controller: nomeController,
              style: TextStyle(),
              decoration:
                  InputDecoration(labelText: "Nome", border: InputBorder.none),
            ),
          ),
          SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white),
                  child: TextField(
                    controller: idadeController,
                    style: TextStyle(),
                    decoration: InputDecoration(
                        labelText: "Idade", border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Atividade Física',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Slider(
                    value: FrequenciaExercicio,
                    min: 0,
                    max: 7,
                    divisions: 7, 
                    label: FrequenciaExercicio
                        .round()
                        .toString(), 
                    onChanged: (double value) {
                      setState(() {
                        FrequenciaExercicio = value;
                      });
                    },
                    activeColor: Colors.blue, 
                    inactiveColor: Colors.grey, 
                  ),
    
                  Text(
                    'Indique a quantidade de vezes por semana que se exercita',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ],
              ))
            ],
          ),
          SizedBox(height: 40),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white),
            child: TextField(
              style: TextStyle(),
              decoration: InputDecoration(
                  labelText: "Comorbidades", border: InputBorder.none),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
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
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Nome da Medicação",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Propósito",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
