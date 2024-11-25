import 'package:flutter/material.dart';

class Ajuda extends StatefulWidget {
  @override
  _AjudaState createState() => _AjudaState();
}

class _AjudaState extends State<Ajuda> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFF472B2B),
        padding: EdgeInsets.all(60),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Ajuda',
            style: TextStyle(
                color: Colors.white, fontSize: 32, fontFamily: 'JuliusSansOne'),
          ),
          SizedBox(height: 60),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                style: TextStyle(color: Colors.white, fontSize: 16,fontFamily: 'JuliusSansOne', fontWeight: FontWeight.bold),
                "Exame de Hemograma: Hemoglobina + Leucocitos + Plaquetas"
                ),
              SizedBox(height: 10),
              Text(
                style: TextStyle(color: Colors.white, fontSize: 14,fontFamily: 'JuliusSansOne'),
                "Homens: 13,8 a 17,2 g/dL \nMulheres: 12,1 a 15,1 g/dL \nGestantes: 11 a 14 g/dL \nCrianças: 11 a 16 g/dL "
                ),
              SizedBox(height: 20),                
              Text(
                style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'JuliusSansOne',fontWeight: FontWeight.bold),
                "Exame de Perfil Lipídico: Colesterol Total + Colesterol HDL + Colesterol LDL + Triglicerídeos"
                ),
              SizedBox(height: 10),
              Text(
                style: TextStyle(color: Colors.white, fontSize: 14,fontFamily: 'JuliusSansOne'),
                "Colesterol Total: Menor que 200 mg\nLDL:Ótimo: Menor que 100 mg Limítrofe: 100-129 mg Alto: Acima de 160 mg\nHDL:Ideal: Maior que 40 mg/dL (homens) Ideal: Maior que 50 mg/dL (mulheres)\nTriglicerídeos: Menor que 150 mg/dL "
                ),                  
              SizedBox(height: 20),
              Text(
                style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'JuliusSansOne',fontWeight: FontWeight.bold),
                "Exame de Tireoide: TSH  + T4 Livre"
                ),
              SizedBox(height: 10),                  
               Text(
                style: TextStyle(color: Colors.white, fontSize: 14,fontFamily: 'JuliusSansOne'),
                "Adultos: 0,4 a 4,0 mIU/L \nGestantes: 0,2 a 3,0 mIU/L\nT4 Livre: 0,8 a 2,0 ng/dL"
                ),
              SizedBox(height: 20),
              Text(
                style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'JuliusSansOne',fontWeight: FontWeight.bold),
                "Exame de Glicemia: Glicose"
                ),
              SizedBox(height: 10),                  
               Text(
                style: TextStyle(color: Colors.white, fontSize: 14,fontFamily: 'JuliusSansOne'),
                "Normal: Menor que 99 mg/dL\nPré-diabetes: 100 a 125 mg/dL\nDiabetes: Maior ou igual a 126 mg/dL"
                ),          
               SizedBox(height: 20),                             
               Text(
                style: TextStyle(color: Colors.white, fontSize: 12,fontFamily: 'JuliusSansOne',fontWeight: FontWeight.bold),
                "Projeto Temático 2: Alice Novello, Eduardo Sandi, Maitê Bueno"
                ),                  
            ],
          )
        ]));
  }
}