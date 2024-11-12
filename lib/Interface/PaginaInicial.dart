import 'package:WelnessTracker/Interface/Exames.dart';
import 'package:WelnessTracker/Interface/Login.dart';
import 'package:WelnessTracker/Model/Exame.dart';
import 'package:WelnessTracker/Model/GerenciarBanco.dart';
import 'package:WelnessTracker/Model/Usuario.dart';
import 'package:WelnessTracker/Model/UsuarioLogado.dart';
import 'package:flutter/material.dart';

class PaginaInicial extends StatefulWidget {

  

  final Usuario usuario; 
  PaginaInicial({Key? key, required this.usuario}) : super(key: key);

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {


    @override
  void initState() {
    super.initState();
    _carregarDataUltimoExame();
    _carregarResumoHemograma();
    
  }

  final GerenciarBanco _gerenciarBanco = GerenciarBanco();
  List<Exame> _exames = [];
  String resumo = "";
  String _resumoHemograma = 'Carregando...'; 

Future<void> _carregarDataUltimoExame() async {
  int? usuarioID = UsuarioLogado.usuario?.id;
  if (usuarioID != null) {
    List<Exame> exames = await _gerenciarBanco.obterExamesPorUsuarioId(usuarioID);

    if (exames.isNotEmpty) {
      Exame ultimoExame = exames.reduce((a, b) {
        DateTime aDate = _converterParaDateTime(a.dataExame);
        DateTime bDate = _converterParaDateTime(b.dataExame);
        return aDate.isAfter(bDate) ? a : b;
      });

      setState(() {
        _exames = [ultimoExame]; 
      });
    }
  }
}

DateTime _converterParaDateTime(String data) {
  List<String> partes = data.split('/');
  int dia = int.parse(partes[0]);
  int mes = int.parse(partes[1]);
  int ano = int.parse(partes[2]);
  return DateTime(ano, mes, dia);
}

Future<String> obterResumoHemograma(int usuarioID) async {
  try {
    // Aguarda os valores dos exames, que são futuros
    double? hemoglobina = await _gerenciarBanco.obterValorExame(usuarioID, 'Hemoglobina');
    double? leucocitos = await _gerenciarBanco.obterValorExame(usuarioID, 'Leucócitos');
    double? plaquetas = await _gerenciarBanco.obterValorExame(usuarioID, 'Plaquetas');

    // Se algum valor for nulo, retorna uma mensagem de erro
    if (hemoglobina == null || leucocitos == null || plaquetas == null) {
      return 'Dados incompletos para o hemograma.';
    }

    String resumo = 'Resumo do Hemograma:\n';

    // Interpretação da Hemoglobina
    if (hemoglobina >= 12 && hemoglobina <= 16) {
      resumo += 'Hemoglobina está dentro do normal ($hemoglobina g/dL).\n';
    } else if (hemoglobina < 12) {
      resumo += 'Hemoglobina abaixo do normal ($hemoglobina g/dL), possível anemia.\n';
    } else {
      resumo += 'Hemoglobina acima do normal ($hemoglobina g/dL), possível policitemia.\n';
    }

    // Interpretação dos Leucócitos
    if (leucocitos >= 4000 && leucocitos <= 11000) {
      resumo += 'Leucócitos dentro do normal ($leucocitos células/μL).\n';
    } else if (leucocitos < 4000) {
      resumo += 'Leucócitos abaixo do normal ($leucocitos células/μL), possível leucopenia.\n';
    } else {
      resumo += 'Leucócitos acima do normal ($leucocitos células/μL), possível infecção ou inflamação.\n';
    }

    // Interpretação das Plaquetas
    if (plaquetas >= 150000 && plaquetas <= 450000) {
      resumo += 'Plaquetas dentro do normal ($plaquetas células/μL).\n';
    } else if (plaquetas < 150000) {
      resumo += 'Plaquetas abaixo do normal ($plaquetas células/μL), possível trombocitopenia.\n';
    } else {
      resumo += 'Plaquetas acima do normal ($plaquetas células/μL), possível trombocitose.\n';
    }

    return resumo;
  } catch (e) {
    return 'Erro ao obter os dados do hemograma: $e';
  }
}


  Future<void> _carregarResumoHemograma() async {
    int? usuarioID = UsuarioLogado.usuario?.id;
    if (usuarioID != null) {
      String resumo = await obterResumoHemograma(usuarioID); // Chama a função
      setState(() {
        _resumoHemograma = resumo; // Atualiza o estado com o resumo
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF472B2B),
      padding: EdgeInsets.only(top: 50, bottom: 20, left: 50, right: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  'Bem Vindo, ${widget.usuario.nome}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontFamily: 'JuliusSansOne'),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Text(
                    "Sair da Conta",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 156, 96, 91),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 80),
          Text('Dados Recentes',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'JuliusSansOne',
                  fontSize: 16)),
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Card(
                  color: Color(0xFF351A1A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40, left: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.favorite, color: Colors.red, size: 80),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 60),
                                child: Center(
                                  child: Text(
                                    'Requer Atenção',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontFamily: 'JuliusSansOne',
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            'Resumo sobre sua Saúde',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                              fontFamily: 'JuliusSansOne',
                            ),
                          ),
                        ),
                        SizedBox(height: 10)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Card(
                  color: Color(0xFF351A1A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40, left: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_month,
                                color: Colors.lightBlueAccent, size: 80),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 60),
                                child: Center(
                                  child: Text(
                                     _exames.isNotEmpty? _exames.first.dataExame: 'Não Disponivel',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontFamily: 'JuliusSansOne',
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            'Data do Ultimo Exame',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                              fontFamily: 'JuliusSansOne',
                            ),
                          ),
                        ),
                        SizedBox(height: 10)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text('Resumo Médico',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'JuliusSansOne',
                  fontSize: 16)),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              width: 3000,
              height: 3000,
              padding: EdgeInsets.only(top: 10, right: 30, left: 30, bottom: 10),
              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFF351A1A)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _resumoHemograma,
                    style: TextStyle(
                      color: Color(0xffF6F6F6),
                    ),
                  ),
                  Text(
                    "Perfil Lipídico: Todos os valores estão dentro das faixas recomendadas, apontando baixo risco para doenças cardiovasculares.",
                    style: TextStyle(
                      color: Color(0xffF6F6F6),
                    ),
                  ),
                  Text(
                    "Função Tireoidiana: TSH e T4 Livre normais, indicando que a tireoide está funcionando adequadamente.",
                    style: TextStyle(
                      color: Color(0xffF6F6F6),
                    ),
                  ),
                  Text(
                    "Glicemia em Jejum: Dentro do esperado, sugerindo controle adequado dos níveis de glicose no sangue.",
                    style: TextStyle(
                      color: Color(0xffF6F6F6),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
