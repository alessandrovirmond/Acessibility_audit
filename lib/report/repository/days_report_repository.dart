import 'package:accessibility_audit/report/model/days_report_model.dart';
import 'package:accessibility_audit/services/http_dio/http_request_massive_data.dart';

class DaysReportRepository {
   final HttpRequestMassiveData _http =
      HttpRequestMassiveData("report/day");
  get stream => _http.percentsStream;

  Future<List<DaysReportModel>> get({Map<String, dynamic>? qsparam}) async {
    Map<String, dynamic> res = await _http.doGetInBatches(qsparam: qsparam, path: "report/day");

    return res["data"]
        .map<DaysReportModel>(
            (r) => DaysReportModel.fromJson(r))
        .toList();
  }
}