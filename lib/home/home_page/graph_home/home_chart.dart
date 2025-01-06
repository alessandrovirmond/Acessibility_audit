import 'package:accessibility_audit/home/home_page/graph_home/controller/chart_data.dart';
import 'package:accessibility_audit/home/home_page/graph_home/controller/home_chart_controller.dart';
import 'package:accessibility_audit/uitls/global_pages_utils/custom_button.dart';
import 'package:accessibility_audit/uitls/global_styles/my_icons.dart';
import 'package:accessibility_audit/uitls/global_styles/pallete_color.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeChart extends StatefulWidget {
  final bool updateWindows;

  const HomeChart({super.key, required this.updateWindows});

  @override
  State<HomeChart> createState() => _HomeChartState();
}

class _HomeChartState extends State<HomeChart> {
  final HomeChartController controller = HomeChartController();

  late Future<Map<String, List<int>>> dataMap;

  @override
  void initState() {
    dataMap = controller.call();

    super.initState();
  }

  void update() {
    setState(() {
      dataMap = controller.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 1200;
        return FutureBuilder<Map<String, List<int>>>(
          future: dataMap,
          builder: (context, snapshot) {
            final Map<String, List<int>>? data = snapshot.data;

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: double.maxFinite,
                  child: const Center(
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        Padding(
                          padding: isSmallScreen
                              ? const EdgeInsets.only(right: 10, left: 10)
                              : const EdgeInsets.only(
                                  right: 15, left: 15, top: 15),
                          child: Row(
                            mainAxisAlignment: isSmallScreen
                                ? MainAxisAlignment.spaceBetween
                                : MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  if (isSmallScreen)
                                    Container(
                                      decoration: BoxDecoration(
                                          color: PalleteColor.blue,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: CustomButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Scaffold(
                                                appBar: AppBar(
                                                  iconTheme:
                                                      const IconThemeData(
                                                    color: Colors.black,
                                                  ),
                                                  backgroundColor: Colors.white,
                                                ),
                                                body: const HomeChart(
                                                  updateWindows: false,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        tooltipText: '',
                                        child: const Icon(MyIcons.maximizar,
                                            color: Colors.white, size: 35),
                                      ),
                                    ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    'Gráfico de Estados',
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 20 : 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: SfCartesianChart(
                              // Fundo branco
                              backgroundColor: Colors.white,
                              plotAreaBorderWidth: 0, // Remove a borda do gráfico
                              primaryXAxis: CategoryAxis(
                                labelStyle: TextStyle(
                                  fontSize: isSmallScreen ? 10 : 12,
                                ),
                                labelIntersectAction:
                                    AxisLabelIntersectAction.trim,
                                majorGridLines: const MajorGridLines(width: 0), // Remove linhas verticais
                              ),
                              primaryYAxis: NumericAxis(
                                maximum: controller.maiorValue1.toDouble() + 5,
                                interval: controller.maiorValue1 != 0
                                    ? (controller.maiorValue1 * 5) / 50
                                    : 1,
                                edgeLabelPlacement: EdgeLabelPlacement.shift,
                                labelStyle: const TextStyle(fontSize: 10),
                                majorTickLines: const MajorTickLines(size: 6),
                                majorGridLines: const MajorGridLines(width: 0), // Remove linhas horizontais
                                numberFormat: NumberFormat('#,##0'),
                                name: "Nota",
                              ),
                              axes: <ChartAxis>[
                                NumericAxis(
                                  maximum: controller.maiorValue.toDouble() + 5,
                                  interval: controller.maiorValue2 != 0
                                      ? (controller.maiorValue2 * 5) / 100
                                      : 1,
                                  opposedPosition: true,
                                  labelStyle: const TextStyle(fontSize: 10),
                                  majorTickLines: const MajorTickLines(size: 6),
                                  axisLine: const AxisLine(width: 0),
                                  majorGridLines: const MajorGridLines(width: 0), // Remove linhas horizontais (eixo oposto)
                                  name: "Páginas",
                                  numberFormat: NumberFormat('#,##0'),
                                ),
                              ],
                              series: [
                                ColumnSeries<ChartData, String>(
                                    dataSource: createChartData(data),
                                    xValueMapper: (ChartData data, _) {
                                      return data.category;
                                    },
                                    yValueMapper: (ChartData data, _) =>
                                        data.value1,
                                    name: "Nota",
                                    color: PalleteColor.blue),
                               
                              ],
                              tooltipBehavior: TooltipBehavior(
                                enable: true,
                                format: 'point.y',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 40,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            color: PalleteColor.blue,
                          ),
                          const SizedBox(width: 5),
                          Text("Nota"),
                          const SizedBox(width: 10),
                          Container(
                            width: 10,
                            height: 10,
                            color: PalleteColor.red,
                          ),
                          const SizedBox(width: 5),
                          Text("Página"),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }
}
