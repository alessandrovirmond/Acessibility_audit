import 'package:accessibility_audit/library/pluto_grid/src/model/pluto_cell.dart';
import 'package:accessibility_audit/library/pluto_grid/src/model/pluto_row.dart';

class PageModel {
  final String? nomePagina;
  final double? nota;
  final int? violacoes;
  final int? elementosAfetados;

  PageModel({
    this.nomePagina,
    this.nota,
    this.violacoes,
    this.elementosAfetados,
  });

  factory PageModel.fromJson(Map<String, dynamic> json) {
    return PageModel(
      nomePagina: json['nome_pagina'],
      nota: (json['nota'] as num?)?.toDouble(),
      violacoes: json['violacoes'],
      elementosAfetados: json['elementos_afetados'],
    );
  }

  PlutoRow toRow() {
    return PlutoRow(
      cells: {
        'Nome da Página': PlutoCell(value: nomePagina),
        'Nota': PlutoCell(value: nota?.toStringAsFixed(2)),
        'Violações': PlutoCell(value: violacoes),
        'Elementos Afetados': PlutoCell(value: elementosAfetados),
      },
    );
  }
}
