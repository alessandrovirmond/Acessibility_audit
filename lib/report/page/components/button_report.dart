import 'package:accessibility_audit/report/controller/days_report_contoller.dart';
import 'package:accessibility_audit/report/controller/enum/enum_report.dart';
import 'package:accessibility_audit/uitls/global_styles/pallete_color.dart';
import 'package:flutter/material.dart';

class ButtonReport extends StatefulWidget {
  final VoidCallback onTap;
  final String label;
  final EnumReport enumReport;
  final DaysReportController controller;

  const ButtonReport({
    Key? key,
    required this.onTap,
    required this.label, 
    required this.enumReport,
    required this.controller,
  }) : super(key: key);

  @override
  _ButtonReportState createState() => _ButtonReportState();
}

class _ButtonReportState extends State<ButtonReport> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: () {
            widget.controller.setReportRange(widget.enumReport);
            widget.onTap(); // Chama o onTap do ReportPage para recarregar a tabela
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: widget.controller.enumReport == widget.enumReport ? Colors.black : _isHovered ? Colors.grey : PalleteColor.yellow,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: widget.controller.enumReport == widget.enumReport ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
