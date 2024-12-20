import 'package:accessibility_audit/config.dart';
import 'package:accessibility_audit/report/controller/enum/enum_report.dart';
import 'package:accessibility_audit/report/controller/i_report_controller.dart';
import 'package:accessibility_audit/report/page/components/button_data.dart';
import 'package:accessibility_audit/report/page/components/button_report.dart';
import 'package:accessibility_audit/report/page/components/button_top_menu.dart';
import 'package:accessibility_audit/report/page/components/button_top_menu_model.dart';
import 'package:flutter/material.dart';
import 'package:accessibility_audit/report/controller/domain_contoller.dart';
import 'package:accessibility_audit/report/page/pluto_grid_page.dart';
import 'package:accessibility_audit/uitls/global_styles/pallete_color.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late IReportController controller;

  @override
  initState() {
    controller = Config.enumReport.controller;

    super.initState();
  }

  void _reloadReport() {
    setState(() {});
  }

  void setReport(
      {required EnumReport enumReport, required String id, bool add = true}) {
    Config.enumReport = enumReport;
    Config.id = id;
    if (add) {
      Config.listButton.add(ButtonData(label: id, enumReport: enumReport));
    }

    controller = Config.enumReport.controller;
    _reloadReport();
  }

  @override
  Widget build(BuildContext context) {
    final double hg = MediaQuery.of(context).size.height;
    final double wd = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: Config.listButton.asMap().entries.map((entry) {
                  final int index = entry.key;
                  final ButtonData buttonData = entry.value;
                  final bool isLast = index == Config.listButton.length - 1;

                  return Row(
                    children: [
                      if (index > 0)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ButtonReport(
                        data: buttonData,
                        callback: () {
                          if (isLast) {
                            setReport(
                              add: false,
                              enumReport: buttonData.enumReport,
                              id: buttonData.label,
                            );
                          } else {
                            Config.listButton.removeRange(
                                index + 1, Config.listButton.length);
                            setReport(
                              add: false,
                              enumReport: buttonData.enumReport,
                              id: buttonData.label,
                            );
                          }
                        },
                      ),
                    ],
                  );
                }).toList(),
              ),
              Row(
                children: [
                  ButtonTopMenu(
                    tile: ButtonTopMenuModel(
                  title: "Colunas",
                  icon: Icons.view_column,
                  onTap: () {
                    controller.stateManager!.showSetColumnsPopup(context);
                  },
                )),SizedBox(width: 10,),
                    ButtonTopMenu(
                    tile: ButtonTopMenuModel(
                  title: "Filtros",
                  icon: Icons.filter_list_alt,
                  onTap: () {
                    controller.stateManager!.showFilterPopup(context);
                  },
                )),
                SizedBox(width: 10,),
                  ValueListenableBuilder<bool>(
                      valueListenable: controller.isGraphActive,
                      builder: (context, isPressed, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: PalleteColor.blue),
                                color:
                                    isPressed ? Colors.grey.shade400 : Colors.white,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  controller.isGraphActive.value =
                                      !controller.isGraphActive.value;
                                },
                                icon: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                   
                                    Icon(
                                      Icons.pie_chart,
                                      color: Colors.black,
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: hg * 0.72,
          width: wd * 0.97,
          child: PlutoGridExamplePage(
            collumn: controller.getCollumnsReport(setReport: setReport),
            futureRow: controller.getRows(id: Config.id),
            title: "Relatório",
            controller: controller,
            stateManager: controller.stateManager,
          ),
        ),
      ],
    );
  }
}
