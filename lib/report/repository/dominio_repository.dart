import 'dart:convert';
import 'package:accessibility_audit/report/model/dominio_model.dart';
import 'package:flutter/services.dart';


class DominioRepository {
  final String localPath;

  DominioRepository({this.localPath = 'assets/relatorio_portais.json'});

  // Método para carregar dados do JSON local
  Future<List<DominioModel>> get() async {
    try {
      final String response = await rootBundle.loadString(localPath);
      final Map<String, dynamic> data = json.decode(response);


      final dominios = data['data']
          .map<DominioModel>((item) => DominioModel.fromJson(item))
          .toList();

      return dominios;
    } catch (e) {
      print("Erro ao carregar dados: $e");
      rethrow;
    }
  }
}
