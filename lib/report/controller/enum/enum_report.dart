enum EnumReport { domain, page, violation, elements }

extension EnumReportExtension on EnumReport {
  /// Retorna o timestamp em milissegundos para a data ajustada às 00h de acordo com o intervalo do EnumReport.
  int get millisecondsSince {
    DateTime now = DateTime.now();
    DateTime calculatedDate;

    switch (this) {
      case EnumReport.domain:
        calculatedDate = DateTime(now.year, now.month - 1, now.day);
        break;
      case EnumReport.page:
        calculatedDate = DateTime(now.year, now.month - 3, now.day);
        break;
      case EnumReport.violation:
        calculatedDate = DateTime(now.year, now.month - 6, now.day);
        break;
      case EnumReport.elements:
        calculatedDate = DateTime(now.year - 1, now.month, now.day);
        break;
    }

    // Ajusta a data para as 00h do dia e retorna o timestamp em milissegundos.
    calculatedDate = DateTime(calculatedDate.year, calculatedDate.month, calculatedDate.day, 0, 0, 0);
    return calculatedDate.millisecondsSinceEpoch;
  }
}
