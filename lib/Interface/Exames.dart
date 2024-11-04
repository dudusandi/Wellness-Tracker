import 'package:WelnessTracker/Model/Exame.dart';
import 'package:WelnessTracker/Model/GerenciarBanco.dart';
import 'package:WelnessTracker/Model/UsuarioLogado.dart';
import 'package:flutter/material.dart';

class Exames extends StatefulWidget {
  @override
  _ExamesState createState() => _ExamesState();
}

class _ExamesState extends State<Exames> {
  final GerenciarBanco _gerenciarBanco = GerenciarBanco();
  List<Exame> _exames = [];

  @override
  void initState() {
    super.initState();
    _carregarExames();
  }

  Future<void> _carregarExames() async {
    int? usuarioID = UsuarioLogado.usuario?.id;
    if (usuarioID != null) {
      List<Exame> exames = await _gerenciarBanco.obterExamesPorUsuarioId(usuarioID);
      setState(() {
        _exames = exames;
      });
    }
  }

  Future<void> _removerExame(int exameId) async {
      await _gerenciarBanco.removerExamePorId(exameId);
      _carregarExames(); // Atualiza a lista após remoção
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Exame removido com sucesso")),
      );
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF472B2B),
      padding: EdgeInsets.all(60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ver Exames',
            style: TextStyle(
                color: Colors.white, fontSize: 32, fontFamily: 'JuliusSansOne'),
          ),
          SizedBox(height: 60),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Color(0xFF351A1A), 
                borderRadius: BorderRadius.circular(20)
              ),
              child: ListView.builder(
                itemCount: _exames.length,
                itemBuilder: (context, index) {
                  final exame = _exames[index];
                  return ListTile(
                    title: Text(
                      exame.nome,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'Data: ${exame.dataExame} - Valor: ${exame.valor}',
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed:  () async =>
                         await _removerExame(exame.id!),
                      
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
