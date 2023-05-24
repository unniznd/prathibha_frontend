import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prathibha_web/common/config.dart';
import 'package:prathibha_web/dashboard/model/attendance_overview_model.dart';

import '../model/dashboard_summary_model.dart';

class DashboardApiProvider {
  Future<DashboardSummaryModel> fetchDashboardSummary(int branchId) async {
    dynamic res;
    try {
      res = await http.get(
          Uri.parse(
            "$baseURL/dashboard-overview/$branchId/",
          ),
          headers: {
            'Authorization': 'Token ${getToken()}'
          }).timeout(const Duration(seconds: 10));
    } catch (e) {
      return DashboardSummaryModel.withError("Error Occured");
    }

    if (res.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(res.body);
      return DashboardSummaryModel.fromJson(responseData);
    }
    return DashboardSummaryModel.withError("Error Occured");
  }

  Future<AttendanceOverview> fetchAttendanceOverview(int branchId) async {
    dynamic res;
    try {
      res = await http.get(
          Uri.parse(
            "$baseURL/today-attendance-overview/$branchId/",
          ),
          headers: {
            'Authorization': 'Token ${getToken()}'
          }).timeout(const Duration(seconds: 10));
    } catch (e) {
      return AttendanceOverview.withError("Error Occured");
    }

    if (res.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(res.body);
      return AttendanceOverview.fromJson(responseData);
    }
    return AttendanceOverview.withError("Error Occured");
  }
}
