import 'package:accessibility_audit/home/home_page/graph_home/home_chart.dart';
import 'package:flutter/material.dart';

class GraphHome extends StatefulWidget {
  const GraphHome({super.key});

  @override
  State<GraphHome> createState() => _GraphHomeState();
}

class _GraphHomeState extends State<GraphHome> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
       
        Expanded(child: HomeChart(updateWindows: false))
      ],
    );

  }
}