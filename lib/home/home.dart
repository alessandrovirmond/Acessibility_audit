import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static late BuildContext homeContext;

  @override
  Widget build(BuildContext context) {
    homeContext = context;

    return  Scaffold(
      body: Column(
        children: [
          Expanded(child: Row(children: [Container(child: Text("Auditoria de Acessibilidade de Portais Municipais"),)],),)
        ],
      ),
    );
  }
}