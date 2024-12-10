import 'package:accessibility_audit/library/pluto_grid/src/manager/pluto_grid_state_manager.dart';
import 'package:accessibility_audit/library/pluto_grid/src/model/pluto_column.dart';
import 'package:accessibility_audit/library/pluto_grid/src/model/pluto_column_type.dart';
import 'package:accessibility_audit/library/pluto_grid/src/model/pluto_row.dart';
import 'package:accessibility_audit/library/pluto_grid/src/pluto_grid_events.dart';
import 'package:accessibility_audit/report/controller/enum/enum_report.dart';
import 'package:accessibility_audit/report/model/domain_model.dart';
import 'package:accessibility_audit/report/repository/domain_repository.dart';
import 'package:flutter/material.dart';

class DomainController {
  final DomainRepository _repository = DomainRepository();
  EnumReport enumReport = EnumReport.domain;
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

    final List<DomainModel> response = await _repository.get();

    return response.map((r) => r.toRow()).toList();
  }

  List<PlutoColumn> getCollumnsReport() {
    return [
      PlutoColumn(
        title: "",
        field: "E",
        width: 60,
        enableColumnDrag: false,
        enableDropToResize: false,
        enableSetColumnsMenuItem: false,
        enableSorting: false,
        enableFilterMenuItem: false,
        enableAutoEditing: false,
        enableEditingMode: false,
        type: PlutoColumnType.text(),
        renderer: (value) {
          return IconButton(
            onPressed: () {
              // Verifica se o botão da linha já está pressionado
              bool isAlreadySelected =
                  value.stateManager.checkedRows.contains(value.row);

              if (isAlreadySelected) {
                // Despressiona o botão, definindo isButtonPressed como null
                isButtonPressed.value = null;
                selected = -1;
              } else {
                // Redefine todos os estados para falso
                for (var element in value.stateManager.checkedRows) {
                  value.stateManager.setRowChecked(element, false);
                }

                // Define o valor da linha pressionada em isButtonPressed
                selected = value.cell.value;
                isButtonPressed.value = value.cell.value;
              }

              // Define o estado de seleção para a linha atual
              value.stateManager.setRowChecked(
                value.row,
                selected == value.cell.value,
              );
              value.stateManager.notifyListeners();
              value.stateManager.onRowChecked!(
                PlutoGridOnRowCheckedOneEvent(
                  row: value.row,
                  rowIdx: value.rowIdx,
                  isChecked: selected == value.cell.value,
                ),
              );
            },
            icon: Icon( Icons.list,
            ),
          );
        },
      ),
     
      PlutoColumn(
          title: "Município",
          field: "Município",
          type: PlutoColumnType.text(),
          width: 180),
      PlutoColumn(
          title: "Domínio",
          field: "Domínio",
          type: PlutoColumnType.text(),
          width: 180),
          PlutoColumn(
          title: "Nota do Domínio",
          field: "Nota do Domínio",
          type: PlutoColumnType.number(locale: "pt_Br"),
          width: 180),
      PlutoColumn(
          title: 'Total de Violações',
          field: 'Total de Violações',
          type: PlutoColumnType.number(locale: "pt_Br"),
          width: 180),
      PlutoColumn(
          title: 'Média de Violações por Página',
          field: 'Média de Violações por Página',
          type: PlutoColumnType.number(locale: "pt_Br"),
          width: 180),
      PlutoColumn(
          title:  'Média de Elementos Afetados por Página',
          field:  'Média de Elementos Afetados por Página',
          type: PlutoColumnType.number(locale: "pt_Br"),
          width: 180),
      
      PlutoColumn(
          title: "Total de Páginas",
          field: "Total de Páginas",
          type: PlutoColumnType.number(locale: "pt_Br"),
          width: 180),
            PlutoColumn(
        title: "",
        field: "H",
        width: 60,
        enableColumnDrag: false,
        enableDropToResize: false,
        enableSetColumnsMenuItem: false,
        enableSorting: false,
        enableFilterMenuItem: false,
        enableAutoEditing: false,
        enableEditingMode: false,
        type: PlutoColumnType.text(),
        renderer: (value) {
          return IconButton(
            onPressed: () {
              // Verifica se o botão da linha já está pressionado
              bool isAlreadySelected =
                  value.stateManager.checkedRows.contains(value.row);

              if (isAlreadySelected) {
                // Despressiona o botão, definindo isButtonPressed como null
                isButtonPressed.value = null;
                selected = -1;
              } else {
                // Redefine todos os estados para falso
                for (var element in value.stateManager.checkedRows) {
                  value.stateManager.setRowChecked(element, false);
                }

                // Define o valor da linha pressionada em isButtonPressed
                selected = value.cell.value;
                isButtonPressed.value = value.cell.value;
              }

              // Define o estado de seleção para a linha atual
              value.stateManager.setRowChecked(
                value.row,
                selected == value.cell.value,
              );
              value.stateManager.notifyListeners();
              value.stateManager.onRowChecked!(
                PlutoGridOnRowCheckedOneEvent(
                  row: value.row,
                  rowIdx: value.rowIdx,
                  isChecked: selected == value.cell.value,
                ),
              );
            },
            icon: Icon(
              value.stateManager.checkedRows.contains(value.row)
                  ? Icons.check_rounded
                  : Icons.history,
            ),
          );
        },
      ),
    ];
  }
}
