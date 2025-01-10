import 'package:accessibility_audit/config.dart';
import 'package:accessibility_audit/home/enum/enum_home.dart';
import 'package:accessibility_audit/uitls/global_styles/styles.dart';
import 'package:flutter/material.dart';
class Menu extends StatefulWidget {
  final Function() onUpdate;

  const Menu({super.key, required this.onUpdate});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Botão Home
        GestureDetector(
          onTap: () {
            setState(() {
              Config.enumHome = EnumHome.home;
              widget.onUpdate();
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: Config.enumHome == EnumHome.home
                  ? Colors.white
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
            child: Text(
              'Home',
              style: Config.enumHome == EnumHome.home ? MyStyles.subtitleGridBlack : MyStyles.titleGridWhite,
            ),
          ),
        ),

        // Botão Relatório
        GestureDetector(
          onTap: () {
            setState(() {
              Config.enumHome = EnumHome.report;
              widget.onUpdate();
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: Config.enumHome == EnumHome.report
                  ? Colors.white
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
            child: Text(
              'Relatório',
              style: Config.enumHome == EnumHome.report ? MyStyles.subtitleGridBlack : MyStyles.titleGridWhite,
            ),
          ),
        ),

        // Botão Sobre
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Sobre'),
                content: const Text('Informações sobre o aplicativo.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Fechar'),
                  ),
                ],
              ),
            );
          },
          child: Text('Sobre', style: Config.enumHome == EnumHome.sobre ? MyStyles.subtitleGridBlack : MyStyles.titleGridWhite),
        ),
      ],
    );
  }
}