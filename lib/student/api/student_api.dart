import 'package:http/http.dart' as http;
import 'package:prathibha_web/common/config.dart';
import 'package:prathibha_web/student/model/class_division_model.dart';
import 'dart:convert';

import 'package:prathibha_web/student/model/student_model.dart';

class StudentApiProvider {
  Future<StudentClassDivisionModel> fetchClassDivision(int branchId) async {
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
      return StudentClassDivisionModel.withError("Error Occured");
    }

    if (res.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(res.body);
      return StudentClassDivisionModel.fromJson(responseData);
    }
    return StudentClassDivisionModel.withError("Error Occured");
  }

  Future<StudentModel> fetchStudentDetails(
    int branchId,
    String standard,
    String division,
    String q,
  ) async {
    dynamic res;
    try {
      res = await http.get(
          Uri.parse(
            "$baseURL/students/$branchId/?standard=$standard&division=$division&q=$q",
          ),
          headers: {
            'Authorization': 'Token ${getToken()}'
          }).timeout(const Duration(seconds: 10));
    } catch (e) {
      return StudentModel.withError("Error Occured");
    }

    if (res.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(res.body);
      return StudentModel.fromJson(responseData);
    }
    return StudentModel.withError("Error Occured");
  }
}
