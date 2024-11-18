import 'package:WelnessTracker/Model/Exame.dart';
import 'package:WelnessTracker/Model/GerenciarBanco.dart';
import 'package:WelnessTracker/Model/Usuario.dart';

class Controller {
  final GerenciarBanco _gerenciarBanco;

  Controller(this._gerenciarBanco);

  

  Future<void> criarExame(String nome,String dataExame,String valor, int usuarioID) async {
            Exame NovoExame = Exame(nome:nome,dataExame: dataExame, valor: valor, usuarioId: usuarioID);
            await _gerenciarBanco.criarExame(NovoExame, usuarioID);
  }


  Future<void> adicionarUsuario(
      String nome, String dataNascimento, String email, String senha) async {

    Usuario novoUsuario = Usuario(
        nome: nome, dataNascimento: dataNascimento, email: email, senha: senha);
    await _gerenciarBanco.criarUsuario(novoUsuario);
  }



  DateTime converterParaDateTime(String data) {
    List<String> partes = data.split('/');
    int dia = int.parse(partes[0]);
    int mes = int.parse(partes[1]);
    int ano = int.parse(partes[2]);
    return DateTime(ano, mes, dia);
  }

  Future<List<Exame>> carregarDataUltimoExame(int usuarioID) async {
    List<Exame> exames = await _gerenciarBanco.obterExamesPorUsuarioId(usuarioID);
    if (exames.isNotEmpty) {
      exames.sort((a, b) => 
          converterParaDateTime(a.dataExame).compareTo(converterParaDateTime(b.dataExame)));
      return [exames.last];
    }
    return [];
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

Future<String> obterResumoPerfilLipidico(int usuarioID) async {
  try {
    double? colesterolTotal = await _gerenciarBanco.obterValorExame(usuarioID, 'Colesterol Total');
    double? colesterolHDL = await _gerenciarBanco.obterValorExame(usuarioID, 'Colesterol HDL');
    double? colesterolLDL = await _gerenciarBanco.obterValorExame(usuarioID, 'Colesterol LDL');
    double? triglicerideos = await _gerenciarBanco.obterValorExame(usuarioID, 'Triglicérideos');

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
    double? tsh = await _gerenciarBanco.obterValorExame(usuarioID, 'TSH');
    double? t4Livre = await _gerenciarBanco.obterValorExame(usuarioID, 'T4 Livre');

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


    bool hemogramaOk = resumoHemograma.contains('Dentro dos valores normais, indicando que não há sinais de anemia, infecções ou problemas de coagulação.');
    if (!hemogramaOk) {
      tudoOk = false;  
    }
  

    bool perfilLipidicoOk = resumoPerfilLipidico.contains('Perfil Lipídico: Todos os valores estão dentro das faixas recomendadas, apontando baixo risco para doenças cardiovasculares.');
    if (!perfilLipidicoOk) {
      tudoOk = false; 
    }
  

    bool tireoideOk = resumoTireoide.contains('Tireoide: Todos os valores estão dentro das faixas recomendadas, indicando funcionamento normal da tireoide.');
    if (!tireoideOk) {
      tudoOk = false;  
    }
  

    bool glicemiaOk = resumoGlicemia.contains('Glicemia em Jejum: O valor da glicose está dentro da faixa recomendada, indicando controle adequado da glicemia.');
    if (!glicemiaOk) {
      tudoOk = false;  
    }
  
    return tudoOk ? 'Ótimo' : 'Requer Atenção';
  } catch (e) {
    return 'Erro ao obter os resultados. Tente novamente mais tarde.';
  }
}


}
