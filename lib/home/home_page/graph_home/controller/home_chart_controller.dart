import 'dart:math';

import 'package:accessibility_audit/home/home_page/graph_home/model/model_graph.dart';

class HomeChartController {
  int maiorValue1 = 0;
  int maiorValue2 = 0;
  int maiorValue = 0;

  Map<String, List<int>> dataMap = {
    "": [100, 100]
  };

  Future<Map<String, List<int>>> call() async {
   // Lista de estados do Brasil (código UF)
  List<String> estados = [
    "AC", "AL", "AM", "AP", "BA", "CE", "DF", "ES", "GO", "MA",
    "MT", "MS", "MG", "PA", "PB", "PE", "PI", "PR", "RJ", "RN",
    "RO", "RR", "RS", "SC", "SE", "SP", "TO"
  ];

  // Inicializar gerador de números aleatórios
  Random random = Random();

  // Criar uma lista de ModelGraph com valores variando
  List<ModelGraph> res = estados.map((estado) {
    int value1 = random.nextInt(11); // Valor aleatório entre 0 e 10
    int value2 = 50 + random.nextInt(951); // Valor aleatório entre 50 e 1000
    return ModelGraph(estado, value1, value2);
  }).toList();


    // Limpar valores anteriores
    maiorValue1 = 0;
    maiorValue2 = 0;
    maiorValue = 0;
    dataMap.clear();

    // Processar cada elemento da lista
    for (var element in res) {
      // Atualizar os maiores valores individuais
      maiorValue1 = element.value1 > maiorValue1 ? element.value1 : maiorValue1;
      maiorValue2 = element.value2 > maiorValue2 ? element.value2 : maiorValue2;

      // Formatar o nome (se necessário)
      var nomeFormatado = element.name;

      // Adicionar os valores ao mapa
      dataMap[nomeFormatado] = [element.value1, element.value2];
    }

    // Calcular o maior valor geral considerando os maiores valores de value1 e value2
    maiorValue = maiorValue1 > maiorValue2 ? maiorValue1 : maiorValue2;

    // Remover entradas desnecessárias
    dataMap.remove("");
    dataMap.remove("no name");

    return dataMap;
  }

  String formatarNome(String nome, int num) {
    if (num > 15) {
      if (nome.length > 7) {
        return nome.replaceAllMapped(
          RegExp('.{1,7}'),
          (match) => '${match.group(0)}\n',
        ).trim();
      }
    } else if (num > 10) {
      if (nome.length > 10) {
        return nome.replaceAllMapped(
          RegExp('.{1,10}'),
          (match) => '${match.group(0)}\n',
        ).trim();
      }
    }

    return nome;
  }
}
