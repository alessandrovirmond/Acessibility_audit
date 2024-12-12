import 'package:accessibility_audit/library/pluto_grid/src/model/pluto_cell.dart';
import 'package:accessibility_audit/library/pluto_grid/src/model/pluto_row.dart';

class DomainModel {
  final String dominio;
  final String municipio;
  final int totalViolacoes;
  final double mediaViolacoesPorPagina;
  final double mediaElementosAfetadosPorPagina;
  final double notaDominio;
  final int totalPaginas;

  DomainModel({
    required this.dominio,
    required this.municipio,
    required this.totalViolacoes,
    required this.mediaViolacoesPorPagina,
    required this.mediaElementosAfetadosPorPagina,
    required this.notaDominio,
    required this.totalPaginas,
  });

  // Método para criar o modelo a partir do JSON
  factory DomainModel.fromJson(Map<String, dynamic> json) {



    return DomainModel(
      dominio: json['dominio'],
      municipio: json['municipio'],
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
        'H': PlutoCell(value: municipio),
        'E': PlutoCell(value: municipio),
        'Domínio': PlutoCell(value: dominio),
        'Município': PlutoCell(value: municipio),
        'Total de Violações': PlutoCell(value: totalViolacoes),
        'Média de Violações por Página': PlutoCell(value: mediaViolacoesPorPagina.toStringAsFixed(2)),
        'Média de Elementos Afetados por Página': PlutoCell(value: mediaElementosAfetadosPorPagina.toStringAsFixed(2)),
        'Nota do Domínio': PlutoCell(value: notaDominio),
        'Total de Páginas': PlutoCell(value: totalPaginas),
      },
    );
  }
}
