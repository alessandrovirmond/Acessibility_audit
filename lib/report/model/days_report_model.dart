
import 'package:accessibility_audit/library/pluto_grid/src/model/pluto_cell.dart';
import 'package:accessibility_audit/library/pluto_grid/src/model/pluto_row.dart';

import '../../../config.dart';

class DaysReportModel {
  final int? id;
  final int? maxTime;
  final int? enter;
  final int? out;
  final int? maxOcup;
  final int? time;


  DaysReportModel( 
      {this.id,
      this.enter,
      this.out,
      this.maxOcup,
      this.time,
      this.maxTime,});

  factory DaysReportModel.fromJson(Map<String, dynamic> json) {
    return DaysReportModel(
      enter: json['enter'] ?? 0,
      out: json['out'] ?? 0,
      maxOcup: json['ocup']['maxOcup'] ?? 0,
      maxTime: json['ocup']['timestamp'] ?? '',
      time: json['timestamp'] ?? "",
    );
  }

  PlutoRow toRows() {
    return PlutoRow(
      cells: {
        'I': PlutoCell(value: time),
        'Hora de ocupção máxima': PlutoCell(
            value: maxTime! < 1
                ? ""
                : DateTime.fromMillisecondsSinceEpoch(maxTime!)
                    .toString()),
        'Data': PlutoCell(
            value: time! < 1
                ? ""
                : DateTime.fromMillisecondsSinceEpoch(time!)
                    .toString()),
        'Ocupação máxima': PlutoCell(value: maxOcup),
        'Entradas': PlutoCell(value: enter),
        'Saídas': PlutoCell(value: out),
      },
    );
  }
}
