import 'package:WelnessTracker/Interface/Login.dart';
import 'package:WelnessTracker/Model/Usuario.dart';
import 'package:flutter/material.dart';

class PaginaInicial extends StatelessWidget {

  final Usuario usuario; 
  PaginaInicial({Key? key, required this.usuario}) : super(key: key);

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
                  'Bem Vindo, ${usuario.nome}',
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
                                    '25/04/2020',
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
              padding: EdgeInsets.only(top: 30, right: 30, left: 30, bottom: 5),
              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFF351A1A)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hemograma Completo: Dentro dos valores normais, indicando que não há sinais de anemia, infecções ou problemas de coagulação",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Perfil Lipídico: Todos os valores estão dentro das faixas recomendadas, apontando baixo risco para doenças cardiovasculares.",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Função Tireoidiana: TSH e T4 Livre normais, indicando que a tireoide está funcionando adequadamente.",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Glicemia em Jejum: Dentro do esperado, sugerindo controle adequado dos níveis de glicose no sangue.",
                    style: TextStyle(
                      color: Colors.white,
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
