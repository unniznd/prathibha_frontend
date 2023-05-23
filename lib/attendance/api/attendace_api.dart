import 'package:http/http.dart' as http;
import 'package:prathibha_web/attendance/model/attendance_model.dart';
import 'package:prathibha_web/attendance/model/class_division_model.dart';
import 'package:prathibha_web/common/config.dart';
import 'dart:convert';

class AttendanceApiProvider {
  Future<AttendanceClassDivisionModel> fetchClassDivision(int branchId) async {
    dynamic res;
    try {
      res = await http.get(
          Uri.parse(
            "$baseURL/branch/$branchId/class/",
          ),
          headers: {
            'Authorization': 'Token ${getToken()}'
          }).timeout(const Duration(seconds: 10));
    } catch (e) {
      return AttendanceClassDivisionModel.withError("Error Occured");
    }

    if (res.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(res.body);
      return AttendanceClassDivisionModel.fromJson(responseData);
    }
    return AttendanceClassDivisionModel.withError("Error Occured");
  }

  Future<AttendanceModel> fetchStudentDetails(
    int branchId,
    String standard,
    String division,
    String q,
    String attendanceStatus,
    String date,
  ) async {
    dynamic res;
    try {
      res = await http.get(
          Uri.parse(
            "$baseURL/attendance/$branchId/?standard=$standard&division=$division&q=$q&attendance=$attendanceStatus&date=$date",
          ),
          headers: {
            'Authorization': 'Token ${getToken()}'
          }).timeout(const Duration(seconds: 10));
    } catch (e) {
      return AttendanceModel.withError("Error Occured");
    }

    if (res.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(res.body);
      return AttendanceModel.fromJson(responseData);
    }
    return AttendanceModel.withError("Error Occured");
  }

  Future<bool> markAsAbsent(
    int branchId,
    int student,
    String date,
  ) async {
    dynamic res;
    try {
      res = await http.post(
        Uri.parse("$baseURL/attendance/$branchId/"),
        headers: {
          'Authorization': 'Token ${getToken()}',
        },
        body: {
          "student": student.toString(),
          "date": date,
        },
      ).timeout(const Duration(seconds: 10));
    } catch (e) {
      return false;
    }

    if (res.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<bool> markAsPresent(
    int branchId,
    int student,
    String date,
  ) async {
    dynamic res;
    try {
      res = await http.delete(
        Uri.parse("$baseURL/attendance/$branchId/"),
        headers: {
          'Authorization': 'Token ${getToken()}',
        },
        body: {
          "student": student.toString(),
          "date": date,
        },
      ).timeout(const Duration(seconds: 10));
    } catch (e) {
      return false;
    }

    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> markAsHoliday(
    int branchId,
    String date,
  ) async {
    dynamic res;
    try {
      res = await http.post(
        Uri.parse("$baseURL/holiday/"),
        headers: {
          'Authorization': 'Token ${getToken()}',
        },
        body: {
          "branch": branchId.toString(),
          "date": date,
        },
      ).timeout(const Duration(seconds: 10));
    } catch (e) {
      return false;
    }

    if (res.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<bool> unmarkAsHoliday(
    int branchId,
    String date,
  ) async {
    dynamic res;
    try {
      res = await http.delete(
        Uri.parse("$baseURL/holiday/"),
        headers: {
          'Authorization': 'Token ${getToken()}',
        },
        body: {
          "branch": branchId.toString(),
          "date": date,
        },
      ).timeout(const Duration(seconds: 10));
    } catch (e) {
      return false;
    }

    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }
}
