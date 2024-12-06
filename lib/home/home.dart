import 'package:accessibility_audit/report/page/report_page.dart';
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
              children: [
                Container(
                  child:
                      Text("Auditoria de Acessibilidade de Portais Municipais"),
                )
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              color: Colors.blue,
              child: ReportPage(),
             
            ),
          )
        ],
      ),
    );
  }
}
