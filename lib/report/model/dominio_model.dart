import 'package:accessibility_audit/library/pluto_grid/src/model/pluto_cell.dart';
import 'package:accessibility_audit/library/pluto_grid/src/model/pluto_row.dart';

class DominioModel {
  final String dominio;
  final int totalViolacoes;
  final double mediaViolacoesPorPagina;
  final double mediaElementosAfetadosPorPagina;
  final double notaDominio;
  final int totalPaginas;

  DominioModel({
    required this.dominio,
    required this.totalViolacoes,
    required this.mediaViolacoesPorPagina,
    required this.mediaElementosAfetadosPorPagina,
    required this.notaDominio,
    required this.totalPaginas,
  });

  // Método para criar o modelo a partir do JSON
  factory DominioModel.fromJson(Map<String, dynamic> json) {
    return DominioModel(
      dominio: json['dominio'],
      totalViolacoes: json['total_violacoes'],
      mediaViolacoesPorPagina: json['media_violacoes_por_pagina'].toDouble(),
      mediaElementosAfetadosPorPagina: json['media_elementos_afetados_por_pagina'].toDouble(),
      notaDominio: json['nota_dominio'].toDouble(),
      totalPaginas: json['total_paginas'],
    );
  }

  // Método para transformar o modelo em uma linha para o PlutoGrid
  PlutoRow toRow() {
    return PlutoRow(
      cells: {
        'Domínio': PlutoCell(value: dominio),
        'Total de Violações': PlutoCell(value: totalViolacoes),
        'Média de Violações por Página': PlutoCell(value: mediaViolacoesPorPagina.toStringAsFixed(2)),
        'Média de Elementos Afetados por Página': PlutoCell(value: mediaElementosAfetadosPorPagina.toStringAsFixed(2)),
        'Nota do Domínio': PlutoCell(value: notaDominio.toStringAsFixed(2)),
        'Total de Páginas': PlutoCell(value: totalPaginas),
      },
    );
  }
}
