import 'package:accessibility_audit/library/pluto_grid/src/manager/pluto_grid_state_manager.dart';
import 'package:accessibility_audit/library/pluto_grid/src/model/pluto_column.dart';
import 'package:accessibility_audit/library/pluto_grid/src/model/pluto_column_type.dart';
import 'package:accessibility_audit/library/pluto_grid/src/model/pluto_row.dart';
import 'package:accessibility_audit/library/pluto_grid/src/pluto_grid_events.dart';
import 'package:accessibility_audit/report/controller/enum/enum_report.dart';
import 'package:accessibility_audit/report/model/dominio_model.dart';
import 'package:accessibility_audit/report/repository/dominio_repository.dart';
import 'package:flutter/material.dart';

class DominioController {
  final DominioRepository _repository = DominioRepository();
  EnumReport enumReport = EnumReport.umMes;
  int selected = -1;
  PlutoGridStateManager? stateManager;

  // ValueNotifier para o evento do grafico ser gerado
  final ValueNotifier<bool> isGraphActive = ValueNotifier<bool>(false);

  // ValueNotifier para o evento do botão
  final ValueNotifier<int?> isButtonPressed = ValueNotifier<int?>(null);

  void setReportRange(EnumReport report) {
    enumReport = report;
  }

  Future<List<PlutoRow>> getRows({Map<String, dynamic>? qsparam}) async {
    isGraphActive.value = false;

    final List<DominioModel> response = await _repository.get();

    return response.map((r) => r.toRow()).toList();
  }

  List<PlutoColumn> getCollumnsReport() {
    return [

      PlutoColumn(
          title: "Domínio",
          field: "Domínio",
          type: PlutoColumnType.text(),
          width: 170),
      PlutoColumn(
          title: 'Total de Violações',
          field: 'Total de Violações',
          type: PlutoColumnType.number(locale: "pt_Br"),
          width: 170),
      PlutoColumn(
          title: 'Média de Violações por Página',
          field: 'Média de Violações por Página',
          type: PlutoColumnType.number(locale: "pt_Br"),
          width: 170),
      PlutoColumn(
          title:  'Média de Elementos Afetados por Página',
          field:  'Média de Elementos Afetados por Página',
          type: PlutoColumnType.number(locale: "pt_Br"),
          width: 170),
      PlutoColumn(
          title: "Nota do Domínio",
          field: "Nota do Domínio",
          type: PlutoColumnType.number(locale: "pt_Br"),
          width: 170),
      PlutoColumn(
          title: "Total de Páginas",
          field: "Total de Páginas",
          type: PlutoColumnType.number(locale: "pt_Br"),
          width: 170),
    ];
  }
}
