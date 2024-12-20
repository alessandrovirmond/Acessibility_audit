import 'package:accessibility_audit/report/page/report_page.dart';
import 'package:accessibility_audit/uitls/global_styles/pallete_color.dart';
import 'package:accessibility_audit/uitls/global_styles/styles.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static late BuildContext homeContext;

  @override
  Widget build(BuildContext context) {
    homeContext = context;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                  "Observatório de Acessibilidade de Portais Municipais",
                    style: MyStyles.titleGrid,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              decoration: BoxDecoration(
                color: PalleteColor.blue,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: ReportPage(),
            ),
          )
        ],
      ),
    );
  }
}
