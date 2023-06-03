class BaseAttendanceDetailedModel {
  String name, phoneNumber, rollNumber;

  BaseAttendanceDetailedModel({
    required this.name,
    required this.phoneNumber,
    required this.rollNumber,
  });
}

class AttendanceDetailedModel {
  List<BaseAttendanceDetailedModel>? students = [];

  String? errorMsg;

  AttendanceDetailedModel.fromJson(Map<String, dynamic> json) {
    students = [];
    for (var student in json['data']) {
      students!.add(
        BaseAttendanceDetailedModel(
          rollNumber: student['roll_number'],
          name: student['student_name'],
          phoneNumber: student['phone_number'],
        ),
      );
    }
  }

  AttendanceDetailedModel.withError(String this.errorMsg);
}
