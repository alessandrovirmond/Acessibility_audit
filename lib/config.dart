import 'package:accessibility_audit/home/enum/enum_home.dart';
import 'package:accessibility_audit/report/controller/enum/enum_report.dart';
import 'package:accessibility_audit/report/page/components/button_data.dart';
import 'package:accessibility_audit/report/page/components/button_report.dart';

class Config {
  static const double sizeLayout = 1200;
  static EnumHome enumHome = EnumHome.home; 
  static EnumReport enumReport = EnumReport.domain;
  static String id = "RJ";
  static List<ButtonData> listButton = [
  ButtonData(label: "RJ", enumReport: EnumReport.domain),
];
  static String backend = "http://localhost:3001/api";
}