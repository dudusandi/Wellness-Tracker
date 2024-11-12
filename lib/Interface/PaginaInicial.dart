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
    _carregarResumoPerfilLipidico();
    _carregarResumoTireoide();
    _carregarResumoGlicemia();
    _carregarResumoCompleto();
  }

  final GerenciarBanco _gerenciarBanco = GerenciarBanco();
  List<Exame> _exames = [];
  String resumo = "";
  String _resumoHemograma = 'Carregando...'; 
  String _resumoPerfilLipidico = 'Carregando...'; 
  String _resumoTireoide = 'Carregando...'; 
  String  _resumoGlicemia= 'Carregando...'; 
  String _resumoCompleto= 'Carregando...'; 

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
    double? hemoglobina = await _gerenciarBanco.obterValorExame(usuarioID, 'Hemoglobina');
    double? leucocitos = await _gerenciarBanco.obterValorExame(usuarioID, 'Leucócitos');
    double? plaquetas = await _gerenciarBanco.obterValorExame(usuarioID, 'Plaquetas');

    if (hemoglobina == null || leucocitos == null || plaquetas == null) {
      return 'Dados incompletos para o hemograma.';
    }

    String resumo = "Hemograma Completo: ";

    bool hemogramaNormal = true;
    if (hemoglobina < 12 || hemoglobina > 16) hemogramaNormal = false;
    if (leucocitos < 4000 || leucocitos > 11000) hemogramaNormal = false;
    if (plaquetas < 150000 || plaquetas > 450000) hemogramaNormal = false;

    if (hemogramaNormal) {
      resumo += "Dentro dos valores normais, indicando que não há sinais de anemia, infecções ou problemas de coagulação.";
    } else {
      resumo += "Fora dos valores normais, podendo indicar algum distúrbio no sangue.";
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
        _resumoHemograma = resumo; 
      });
    }
  }

Future<String> obterResumoPerfilLipidico(int usuarioID) async {
  try {
    double? colesterolTotal = await _gerenciarBanco.obterValorExame(usuarioID, 'Colesterol Total');
    double? colesterolHDL = await _gerenciarBanco.obterValorExame(usuarioID, 'Colesterol HDL');
    double? colesterolLDL = await _gerenciarBanco.obterValorExame(usuarioID, 'Colesterol LDL');
    double? triglicerideos = await _gerenciarBanco.obterValorExame(usuarioID, 'Triglicerídeos');

    if (colesterolTotal == null || colesterolHDL == null || colesterolLDL == null || triglicerideos == null) {
      return 'Dados incompletos para o perfil lipídico.';
    }

    bool perfilDentroDoNormal = true;

    if (colesterolTotal >= 200) {
      perfilDentroDoNormal = false;
    }

    if (colesterolHDL <= 40) {
      perfilDentroDoNormal = false;
    }

    if (colesterolLDL >= 160) {
      perfilDentroDoNormal = false;
    }

    if (triglicerideos >= 150) {
      perfilDentroDoNormal = false;
    }

    if (perfilDentroDoNormal) {
      return 'Perfil Lipídico: Todos os valores estão dentro das faixas recomendadas, apontando baixo risco para doenças cardiovasculares.';
    } else {
      return 'Perfil Lipídico: Alguns valores estão fora das faixas recomendadas, podendo indicar risco aumentado para doenças cardiovasculares.';
    }
  } catch (e) {
    return 'Erro ao obter os dados do perfil lipídico: $e';
  }
}

Future<String> obterResumoTireoideSimples(int usuarioID) async {
  try {
    // Obtém os valores dos exames
    double? tsh = await _gerenciarBanco.obterValorExame(usuarioID, 'TSH');
    double? t4Livre = await _gerenciarBanco.obterValorExame(usuarioID, 'T4 Livre');

    // Verifica se algum valor é nulo
    if (tsh == null || t4Livre == null) {
      return 'Dados incompletos para a análise da tireoide.';
    }

    bool tireoideDentroDoNormal = true;

    if (tsh < 0.4 || tsh > 4.0) {  
      tireoideDentroDoNormal = false;
    }

    if (t4Livre < 0.7 || t4Livre > 1.8) {  
      tireoideDentroDoNormal = false;
    }

    if (tireoideDentroDoNormal) {
      return 'Tireoide: Todos os valores estão dentro das faixas recomendadas, indicando funcionamento normal da tireoide.';
    } else {
      return 'Tireoide: Alguns valores estão fora das faixas recomendadas, podendo indicar disfunção tireoidiana.';
    }
  } catch (e) {
    return 'Erro ao obter os dados da tireoide: $e';
  }
}

Future<String> obterResumoGlicemiaSimples(int usuarioID) async {
  try {
    double? glicose = await _gerenciarBanco.obterValorExame(usuarioID, 'Glicose');

    if (glicose == null) {
      return 'Dados incompletos para a análise de glicemia.';
    }

    bool glicemiaDentroDoNormal = glicose >= 70 && glicose <= 99;

    if (glicemiaDentroDoNormal) {
      return 'Glicemia em Jejum: O valor da glicose está dentro da faixa recomendada, indicando controle adequado da glicemia.';
    } else {
      return 'Glicemia em Jejum: O valor da glicose está fora da faixa recomendada, podendo indicar risco de diabetes ou hipoglicemia.';
    }
  } catch (e) {
    return 'Erro ao obter os dados da glicemia: $e';
  }
}

Future<String> obterResumoCompleto(int usuarioID) async {
  try {
    String? resumoHemograma = await obterResumoHemograma(usuarioID);
    String? resumoPerfilLipidico = await obterResumoPerfilLipidico(usuarioID);
    String? resumoTireoide = await obterResumoTireoideSimples(usuarioID);
    String? resumoGlicemia = await obterResumoGlicemiaSimples(usuarioID);


    bool tudoOk = true;  

    // Verifica o Hemograma
    if (resumoHemograma != null) {
      bool hemogramaOk = resumoHemograma.contains('Dentro dos valores normais, indicando que não há sinais de anemia, infecções ou problemas de coagulação.');
      if (!hemogramaOk) {
        tudoOk = false;  
      }
    }

    // Verifica o Perfil Lipídico
    if (resumoPerfilLipidico != null) {
      bool perfilLipidicoOk = resumoPerfilLipidico.contains('Perfil Lipídico: Todos os valores estão dentro das faixas recomendadas, apontando baixo risco para doenças cardiovasculares.');
      if (!perfilLipidicoOk) {
        tudoOk = false; 
      }
    }

    // Verifica a Tireoide
    if (resumoTireoide != null) {
      bool tireoideOk = resumoTireoide.contains('Tireoide: Todos os valores estão dentro das faixas recomendadas, indicando funcionamento normal da tireoide.');
      if (!tireoideOk) {
        tudoOk = false;  
      }
    }

    // Verifica a Glicemia
    if (resumoGlicemia != null) {
      bool glicemiaOk = resumoGlicemia.contains('Glicemia em Jejum: O valor da glicose está dentro da faixa recomendada, indicando controle adequado da glicemia.');
      if (!glicemiaOk) {
        tudoOk = false;  
      }
    }

    return tudoOk ? 'Tudo Ok' : 'Requer Atenção';
  } catch (e) {
    return 'Erro ao obter os resultados. Tente novamente mais tarde.';
  }
}



Future<void> _carregarResumoCompleto() async {
  int? usuarioID = UsuarioLogado.usuario?.id;
  if (usuarioID != null) {
    String resumoCompleto = await obterResumoCompleto(usuarioID); 
    setState(() {
      _resumoCompleto = resumoCompleto; 
    });
  }
}



Future<void> _carregarResumoGlicemia() async {
  int? usuarioID = UsuarioLogado.usuario?.id;
  if (usuarioID != null) {
    String resumo = await obterResumoGlicemiaSimples(usuarioID); 
    setState(() {
      _resumoGlicemia = resumo; 
    });
  }
}

Future<void> _carregarResumoTireoide() async {
  int? usuarioID = UsuarioLogado.usuario?.id;
  if (usuarioID != null) {
    String resumo = await obterResumoTireoideSimples(usuarioID); 
    setState(() {
      _resumoTireoide = resumo; 
    });
  }
}

Future<void> _carregarResumoPerfilLipidico() async {
  int? usuarioID = UsuarioLogado.usuario?.id;
  if (usuarioID != null) {
    String resumo = await obterResumoPerfilLipidico(usuarioID); 
    setState(() {
      _resumoPerfilLipidico = resumo; 
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
                                    _resumoCompleto,
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
                    _resumoPerfilLipidico,
                    style: TextStyle(
                      color: Color(0xffF6F6F6),
                    ),
                  ),
                  Text(
                    _resumoTireoide,
                    style: TextStyle(
                      color: Color(0xffF6F6F6),
                    ),
                  ),
                  Text(
                    _resumoGlicemia,
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
