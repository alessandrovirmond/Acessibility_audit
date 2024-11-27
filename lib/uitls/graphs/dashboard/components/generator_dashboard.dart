import 'package:accessibility_audit/library/pluto_grid/src/helper/filtered_list.dart';
import 'package:accessibility_audit/library/pluto_grid/src/model/pluto_row.dart';
import 'package:accessibility_audit/uitls/graphs/dashboard/components/graphs.dart';
import 'package:accessibility_audit/uitls/graphs/dashboard/controller/generator_file/pdf_generator.dart';
import 'package:accessibility_audit/uitls/graphs/dashboard/models/enum_graph_style.dart';
import 'package:accessibility_audit/uitls/graphs/dashboard/models/model_selector_graph.dart';
import 'package:accessibility_audit/uitls/graphs/dashboard/models/models_graph.dart';
import 'package:accessibility_audit/uitls/global_styles/pallete_color.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GeneratorDashboard extends StatefulWidget {
  final List<String> collumns;
  final FilteredList<PlutoRow> row;
  final List<String> collumnsNumber;
  const GeneratorDashboard(
      {super.key,
      required this.collumns,
      required this.row,
      required this.collumnsNumber});

  @override
  State<GeneratorDashboard> createState() => _GeneratorDashboardState();
}

final RenderPdf pdf = RenderPdf();
// ignore: unused_element
late GlobalKey<SfCircularChartState> _circularChartKey;

TextEditingController controllerA = TextEditingController();
TextEditingController controllerB = TextEditingController();
TextEditingController controllerType = TextEditingController();
bool generator = false;
List<ModelGraph> model = [];
int total = 0;

late bool noNumber;

class _GeneratorDashboardState extends State<GeneratorDashboard> {
  List<TextEditingController> txt = [controllerA, controllerB, controllerType];

  void buildGraph() {
    if (controllerType.text == "Soma") {
      if (controllerA.text != controllerB.text) {
        List<String> a = [];
        List<int> b = [];
        for (var element in widget.row) {
          a.add(element.cells[controllerA.text]!.value.toString());
          b.add(element.cells[controllerB.text]!.value);
        }
        Map<String, int> mapa = {};
        int i = 0;

        // ignore: unused_local_variable
        for (var element in a) {
          if (mapa.containsKey(a[i])) {
            mapa[a[i]] = mapa[a[i]]! + b[i];
          } else {
            mapa.addAll({a[i]: b[i]});
          }
          i++;
        }
        model.clear();
        total = 0;
        mapa.forEach(((key, value) {
          model.add(ModelGraph(key, value.toDouble()));
          total = total + value;
        }));
      }
    } else {
      Map<String, double> map = {};
      total = 0;
      for (var element in widget.row) {
        total += 1;
        if (map
            .containsKey(element.cells[controllerA.text]!.value.toString())) {
          map[element.cells[controllerA.text]!.value.toString()] =
              map[element.cells[controllerA.text]!.value.toString()]! + 1;
        } else {
          map.addAll({element.cells[controllerA.text]!.value.toString(): 1});
        }
      }
      model.clear();
      map.forEach((key, value) {
        model.add(ModelGraph(key, value));
      });
    }
    setState(() {
      generator = true;
    });
  }

  @override
  void initState() {
    super.initState();

    _circularChartKey = GlobalKey();

    // Filtra as colunas para remover aquelas com mais de 500 valores distintos
    widget.collumns.removeWhere((collum) {
      // Verifica se a coluna não é "EPC" ou vazia, e se tem mais de 500 valores distintos
      return collum.isEmpty ||
          collum == "EPC" ||
          widget.row.map((row) => row.cells[collum]!.value).toSet().length >
              1000;
    });

    controllerA.text = widget.collumns[0];
    controllerType.text = "Quantitativo";
    noNumber = widget.collumnsNumber.isEmpty;

    controllerB.text = noNumber ? controllerA.text : widget.collumnsNumber[0];

    buildGraph();

    for (var element in txt) {
      element.addListener(() {
        buildGraph();

        setState(() {
          generator = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Linha superior com as opções de gráfico e PDF
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.pie_chart, color: Colors.black),
                      onPressed: () => setState(
                          () => ModelSelectorGraph.graph = GraphStyle.pie),
                    ),
                    IconButton(
                      icon: const Icon(FeatherIcons.triangle,
                          color: Colors.black),
                      onPressed: () => setState(
                          () => ModelSelectorGraph.graph = GraphStyle.pyramid),
                    ),
                    IconButton(
                      icon: const Icon(Icons.bar_chart, color: Colors.black),
                      onPressed: () => setState(
                          () => ModelSelectorGraph.graph = GraphStyle.bar),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => pdf.renderPdf(GraphSelectorWidget.dash, ""),
                  icon:
                      const Icon(FontAwesomeIcons.filePdf, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Conteúdo principal
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Coluna com dropdowns
                  SizedBox(
                    width: 200,
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("    Coluna"),
                              DropdownSearch<String>(
                                popupProps:
                                    const PopupProps.menu(showSearchBox: false),
                                items: widget.collumns,
                                onChanged: (value) => controllerA.text = value!,
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    hintText: "CHAVE",
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(.7),
                                    ),
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                                selectedItem: controllerA.text,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("   Tipo"),
                              DropdownSearch<String>(
                                popupProps:
                                    const PopupProps.menu(showSearchBox: false),
                                items: const ["Quantitativo", "Soma"],
                                onChanged: (value) =>
                                    controllerType.text = value!,
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    hintText: "Tipo",
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(.7),
                                    ),
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                                selectedItem: controllerType.text,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (controllerType.text == "Soma" && !noNumber)
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("   Coluna numérica"),
                                DropdownSearch<String>(
                                  popupProps: const PopupProps.menu(
                                      showSearchBox: false),
                                  items: widget.collumnsNumber,
                                  onChanged: (value) =>
                                      controllerB.text = value!,
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      hintText: "NUMBER",
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black.withOpacity(.7),
                                      ),
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  selectedItem: controllerB.text,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Gráfico ocupando a maior parte da linha
                  Expanded(
                    child: generator
                        ? GraphSelectorWidget(model: model, t: total.toDouble())
                        : const Center(child: Text("No data to display")),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
