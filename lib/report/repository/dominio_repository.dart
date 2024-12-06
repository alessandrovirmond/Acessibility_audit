import 'dart:convert';
import 'package:accessibility_audit/report/model/dominio_report.dart';
import 'package:accessibility_audit/services/http_dio/http_request_massive_data.dart';
import 'package:flutter/services.dart';

class DominioRepository {
  final HttpRequestMassiveData _http = HttpRequestMassiveData("report/day");

  // Função para obter os dados do JSON local
  Future<List<DominioModel>> getData() async {
    try {
      // Carregando o arquivo JSON do assets
      final String response = await rootBundle.loadString('assets/relatorio_portais.json');
      
      // Convertendo a string JSON para mapa
      final Map<String, dynamic> data = json.decode(response);

      // Mapeando os dados para o modelo de DominioModel
      List<DominioModel> dominioList = [];
      
      data.forEach((key, value) {
        dominioList.add(DominioModel.fromJson(value));  // Cria o modelo a partir do json
      });

      return dominioList;
    } catch (error) {
      print("Erro ao carregar o arquivo JSON: $error");
      rethrow;
    }
  }

  // Função para obter os dados do JSON remoto
  Future<List<DominioModel>> get({Map<String, dynamic>? qsparam}) async {
    final response = await getData();
    return response;  // Aqui já temos os dados prontos
  }
}


/* import 'package:accessibility_audit/report/model/dominio_report.dart';
import 'package:accessibility_audit/services/http_dio/http_request_massive_data.dart';

class DominioRepository {
   final HttpRequestMassiveData _http =
      HttpRequestMassiveData("report/day");
  get stream => _http.percentsStream;

  Future<List<DominioModel>> get({Map<String, dynamic>? qsparam}) async {
    Map<String, dynamic> res = await _http.doGetInBatches(qsparam: qsparam, path: "report/day");

    return res["data"]
        .map<DominioModel>(
            (r) => DominioModel.fromJson(r))
        .toList();
  }
} */