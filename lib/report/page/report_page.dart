import 'package:accessibility_audit/report/controller/enum/enum_report.dart';
import 'package:accessibility_audit/report/page/components/button_report.dart';
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
  DomainController controller = DomainController();

  void _reloadReport() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double hg = MediaQuery.of(context).size.height;
    final double wd = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ButtonReport(
                      controller: controller,
                      enumReport: EnumReport.domain,
                      onTap: _reloadReport,
                      label: "RJ",
                    ),
                  ],
                ),
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
                              color: isPressed
                                  ? Colors.grey.shade400
                                  : Colors.white,
                            ),
                            child: IconButton(
                              onPressed: () {
                                controller.isGraphActive.value =
                                    !controller.isGraphActive.value;
                              },
                              icon: Row(
                                children: [
                                  Text(
                                    "Gerar Gráfico",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
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
                    })
              ],
            ),
          ),
        ),
        SizedBox(
          
          height: hg * 0.72,
          width: wd * 0.95,
          child: PlutoGridExamplePage(
            collumn: controller.getCollumnsReport(),
            futureRow: controller.getRows(
                qsparam: {"start": controller.enumReport.millisecondsSince}),
            title: "Dias",
            isButtonPressed: controller.isButtonPressed,
            isGraphActive: controller.isGraphActive,
            stateManager: controller.stateManager,
          ),
        ),
      ],
    );
  }
}
