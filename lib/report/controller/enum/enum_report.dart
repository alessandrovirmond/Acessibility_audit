import 'package:accessibility_audit/report/controller/domain_contoller.dart';
import 'package:accessibility_audit/report/controller/i_report_controller.dart';
import 'package:accessibility_audit/report/controller/page_controllert.dart';

enum EnumReport { domain, page, violation, elements }

extension EnumReportExtension on EnumReport {

  IReportController get controller {
   

    switch (this) {
      case EnumReport.domain:
        return DomainController();
        
      case EnumReport.page:
        return PageController();
        
      case EnumReport.violation:
        return DomainController();
      
      case EnumReport.elements:
       return DomainController();
    }
  }

  
}