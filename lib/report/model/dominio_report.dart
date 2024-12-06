import 'dart:convert';
import 'dart:js_interop';
import 'package:accessibility_audit/library/pluto_grid/src/model/pluto_cell.dart';
import 'package:accessibility_audit/library/pluto_grid/src/model/pluto_row.dart';

class DominioModel {
  final String? dominio;
  final int? totalViolacoes;
  final double? mediaViolacoesPorPagina;
  final double? mediaElementosAfetadosPorPagina;
  final double? notaDominio;
  final int? totalPaginas;

  DominioModel({
    this.dominio,
    this.totalViolacoes,
    this.mediaViolacoesPorPagina,
    this.mediaElementosAfetadosPorPagina,
    this.notaDominio,
    this.totalPaginas,
  });

  // A função fromJson agora faz o cálculo correto para as médias
  factory DominioModel.fromJson(Map<String, dynamic> json) {
    // Acessando as páginas do domínio
    final List<dynamic> paginas = json['notas_paginas'] ?? [];
    
    // Calculando o total de violações, a média de violações por página e a média de elementos afetados por página
    int totalViolacoes = 0;
    int totalElementosAfetados = 0;

for (var pagina in paginas) {
  totalViolacoes += int.tryParse(pagina['violacoes'].toString()) ?? 0;
  totalElementosAfetados += int.tryParse(pagina['elementos_afetados'].toString()) ?? 0;
}


    double mediaViolacoesPorPagina = 0.0;
    double mediaElementosAfetadosPorPagina = 0.0;

    if (paginas.isNotEmpty) {
      mediaViolacoesPorPagina = totalViolacoes / paginas.length;
      mediaElementosAfetadosPorPagina = totalElementosAfetados / paginas.length;
    }

    // Calculando a nota do domínio, com base nas páginas
    double notaDominio = 0.0;
    for (var pagina in paginas) {
      notaDominio += pagina['nota'] ?? 0.0;
    }
    notaDominio = (paginas.isNotEmpty) ? (notaDominio / paginas.length) : 0.0;

    return DominioModel(
      dominio: json['dominio'] ?? '',
      totalViolacoes: totalViolacoes,
      mediaViolacoesPorPagina: mediaViolacoesPorPagina,
      mediaElementosAfetadosPorPagina: mediaElementosAfetadosPorPagina,
      notaDominio: notaDominio,
      totalPaginas: paginas.length,
    );
  }

  PlutoRow toRows() {
    return PlutoRow(
      cells: {
        'Domínio': PlutoCell(value: dominio),
        'Total de Violações': PlutoCell(value: totalViolacoes),
        'Média de Violações por Página': PlutoCell(value: mediaViolacoesPorPagina?.toStringAsFixed(2)),
        'Média de Elementos Afetados por Página': PlutoCell(value: mediaElementosAfetadosPorPagina?.toStringAsFixed(2)),
        'Nota do Domínio': PlutoCell(value: notaDominio?.toStringAsFixed(2)),
        'Total de Páginas': PlutoCell(value: totalPaginas),
      },
    );
  }
}
