import 'package:accessibility_audit/library/pluto_grid/src/plugin/pluto_aggregate_column_footer.dart';
import 'package:accessibility_audit/report/controller/enum/enum_report.dart';
import 'package:accessibility_audit/report/repository/page_repository.dart';
import 'package:accessibility_audit/uitls/global_styles/pallete_color.dart';
import 'package:flutter/material.dart';
import 'package:accessibility_audit/library/pluto_grid/src/manager/pluto_grid_state_manager.dart';
import 'package:accessibility_audit/library/pluto_grid/src/model/pluto_column.dart';
import 'package:accessibility_audit/library/pluto_grid/src/model/pluto_column_type.dart';
import 'package:accessibility_audit/library/pluto_grid/src/model/pluto_row.dart';
import 'package:accessibility_audit/library/pluto_grid/src/pluto_grid_events.dart';
import 'package:accessibility_audit/report/controller/i_report_controller.dart';
import 'package:accessibility_audit/report/model/page_model.dart';

class PageController implements IReportController {
  final PageRepository _repository = PageRepository();
  int selected = -1;
  PlutoGridStateManager? stateManager;

  // ValueNotifier para controlar o gráfico
  final ValueNotifier<bool> isGraphActive = ValueNotifier<bool>(false);

  // ValueNotifier para controlar o botão
  final ValueNotifier<int?> isButtonPressed = ValueNotifier<int?>(null);

  Future<List<PlutoRow>> getRows({required String id}) async {
    isGraphActive.value = false;

    final List<PageModel> response = await _repository.get();

    return response.map((page) => page.toRow()).toList();
  }

  List<PlutoColumn> getCollumnsReport({required void setReport({required EnumReport enumReport, required String id})}) {
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
            onPressed: () {},
            icon: const Icon(Icons.list,
            color: PalleteColor.blue,
            ),
          );
        },
      ),
      PlutoColumn(
        title: "Página",
        field: "Página",
        type: PlutoColumnType.text(),
        width: 500,
         footerRenderer: (context) => PlutoAggregateColumnFooter(
        rendererContext: context,
        formatAsCurrency: false,
        type: PlutoAggregateColumnType.count,
        alignment: Alignment.centerLeft,
        titleSpanBuilder: (text) {
          return [
            const TextSpan(
              text: 'QNT:  ',
              style: TextStyle(color: Colors.red),
            ),
            TextSpan(text: text.replaceAll('\$', "").replaceAll(",", ".")),
          ];
        },
      ),
      ),
      PlutoColumn(
        title: "Nota",
        field: "Nota",
        type: PlutoColumnType.number(locale: "pt_BR", format: "#,##0.00"),
        width: 100,
      ),
      PlutoColumn(
        title: "Violações",
        field: "Violações",
        type: PlutoColumnType.number(locale: "pt_BR"),
        width: 120,
        footerRenderer: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PlutoAggregateColumnFooter(
                rendererContext: context,
                formatAsCurrency: false,
                type: PlutoAggregateColumnType.sum,
                alignment: Alignment.center,
                titleSpanBuilder: (text) {
                  return [
                    const TextSpan(
                      text: 'Total: ',
                      style: TextStyle(color: Colors.red),
                    ),
                    TextSpan(
                        text:
                           text),
                  ];
                },
              ),
              PlutoAggregateColumnFooter(
                rendererContext: context,
                formatAsCurrency: false,
                type: PlutoAggregateColumnType.average,
                alignment: Alignment.center,
                titleSpanBuilder: (text) {
                  return [
                    const TextSpan(
                      text: 'Média: ',
                      style: TextStyle(color: Colors.red),
                    ),
                    TextSpan(
                        text:
                           text),
                  ];
                },
              ),
            ],
          );
        },
      ),
      PlutoColumn(
        title: "Elementos Afetados",
        field: "Elementos Afetados",
        type: PlutoColumnType.number(locale: "pt_BR"),
        width: 180,
        footerRenderer: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PlutoAggregateColumnFooter(
                rendererContext: context,
                formatAsCurrency: false,
                type: PlutoAggregateColumnType.sum,
                alignment: Alignment.center,
                titleSpanBuilder: (text) {
                  return [
                    const TextSpan(
                      text: 'Total: ',
                      style: TextStyle(color: Colors.red),
                    ),
                    TextSpan(
                        text:
                           text),
                  ];
                },
              ),
              PlutoAggregateColumnFooter(
                rendererContext: context,
                formatAsCurrency: false,
                type: PlutoAggregateColumnType.average,
                alignment: Alignment.center,
                titleSpanBuilder: (text) {
                  return [
                    const TextSpan(
                      text: 'Média: ',
                      style: TextStyle(color: Colors.red),
                    ),
                    TextSpan(
                        text:
                           text),
                  ];
                },
              ),
            ],
          );
        },
      ),
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
        frozen: PlutoColumnFrozen.end,
        type: PlutoColumnType.text(),
        renderer: (value) {
          return IconButton(
            onPressed: () {
              bool isAlreadySelected =
                  value.stateManager.checkedRows.contains(value.row);

              if (isAlreadySelected) {
                isButtonPressed.value = null;
                selected = -1;
              } else {
                for (var element in value.stateManager.checkedRows) {
                  value.stateManager.setRowChecked(element, false);
                }

                selected = value.cell.value;
                isButtonPressed.value = value.cell.value;
              }

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
