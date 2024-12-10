import 'dart:convert';
import 'package:accessibility_audit/report/model/domain_model.dart';
import 'package:flutter/services.dart';


class DomainRepository {
  final String localPath;

  DomainRepository({this.localPath = 'assets/relatorio_portais.json'});

  // Método para carregar dados do JSON local
  Future<List<DomainModel>> get() async {
    try {
      final String response = await rootBundle.loadString(localPath);
      final Map<String, dynamic> data = json.decode(response);


      final Domains = data['data']
          .map<DomainModel>((item) => DomainModel.fromJson(item))
          .toList();

      return Domains;
    } catch (e) {
      print("Erro ao carregar dados: $e");
      rethrow;
    }
  }
}
