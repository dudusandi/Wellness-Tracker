import 'package:wellness_tracker/Controlador/Controller.dart';
import 'package:wellness_tracker/Model/Exame.dart';
import 'package:wellness_tracker/Model/GerenciarBanco.dart';
import 'package:wellness_tracker/Model/UsuarioLogado.dart';
import 'package:flutter/material.dart';

class Exames extends StatefulWidget {
  @override
  _ExamesState createState() => _ExamesState();
}

class _ExamesState extends State<Exames> {
  final GerenciarBanco _gerenciarBanco = GerenciarBanco();
  late final Controller _controller;
  List<Exame> _exames = [];

  @override
  void initState() {
    super.initState();
    _controller = Controller(_gerenciarBanco);
    _carregarExames();
  }

  Future<void> _carregarExames() async {
    int? usuarioID = UsuarioLogado.usuario?.id;
    if (usuarioID != null) {
      List<Exame> exames = await _controller.obterExames(usuarioID);
      setState(() {
        _exames = exames;
      });
    }
  }

  Future<void> _removerExame(int exameId) async {
    await _controller.removerExame(exameId);
    _carregarExames();
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
                  borderRadius: BorderRadius.circular(20)),
              child: _exames.isEmpty
                  ? Center(
                      child: Text(
                        'Nenhum exame encontrado.',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
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
                            onPressed: () async =>
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
