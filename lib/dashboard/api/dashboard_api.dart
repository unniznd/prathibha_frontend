import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prathibha_web/common/config.dart';
import 'package:prathibha_web/dashboard/model/attendace_detailed_model.dart';
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

  Future<AttendanceDetailedModel> detailedAttendance(
    int branchId,
    String standard,
    String division,
  ) async {
    dynamic res;
    try {
      res = await http.get(
          Uri.parse(
            "$baseURL/attendance/$branchId/detailed/?standard=$standard&division=$division",
          ),
          headers: {
            'Authorization': 'Token ${getToken()}'
          }).timeout(const Duration(seconds: 10));
    } catch (e) {
      return AttendanceDetailedModel.withError("Error Occured");
    }

    if (res.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(res.body);
      return AttendanceDetailedModel.fromJson(responseData);
    }
    return AttendanceDetailedModel.withError("Error Occured");
  }

  Future notifyAbsentees(
    int branchId,
    String standard,
    String division,
  ) async {
    dynamic res;
    try {
      res = await http.post(
          Uri.parse(
            "$baseURL/attendance/$branchId/message/?standard=$standard&division=$division",
          ),
          headers: {'Authorization': 'Token ${getToken()}'});
    } catch (e) {
      return false;
    }

    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }
}
