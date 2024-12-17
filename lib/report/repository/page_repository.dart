import 'dart:convert';
import 'package:accessibility_audit/config.dart';
import 'package:accessibility_audit/report/model/page_model.dart';
import 'package:flutter/services.dart';
import 'package:accessibility_audit/report/controller/enum/enum_report.dart';

class PageRepository {
  final String localPath;

  PageRepository({this.localPath = 'assets/relatorio_portais.json'});

  // Método para carregar dados do JSON local
  Future<List<PageModel>> get() async {

    try {
      final String response = await rootBundle.loadString(localPath);
      final Map<String, dynamic> data = json.decode(response);

      // Filtrar os dados com base no município (Config.id)
      final municipioData = data['data'].firstWhere(
        (item) => item['municipio'] == Config.id,
        orElse: () => null,
      );

      if (municipioData == null) {
        print("Nenhum dado encontrado para o município: ${Config.id}");
        return [];
      }

      // Mapear as páginas do município para PageModel
      final pages = (municipioData['notas_paginas'] as List<dynamic>)
          .map<PageModel>((item) => PageModel.fromJson(item))
          .toList();

      return pages;
    } catch (e) {
      print("Erro ao carregar dados: $e");
      rethrow;
    }
  }
}
