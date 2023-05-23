class BaseAttendanceModel {
  int admissionNumber;
  String name, standard, division, reason;
  bool isAbsent;
  bool isMarkingAttendace = false;

  BaseAttendanceModel({
    required this.admissionNumber,
    required this.name,
    required this.standard,
    required this.division,
    required this.reason,
    required this.isAbsent,
    this.isMarkingAttendace = false,
  });
}

class AttendanceModel {
  List<BaseAttendanceModel>? studentModel;
  int? totalCount;
  int? absentCount;

  bool? isHoliday;

  String? holidayMsg;
  String? errorMsg;

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    studentModel = [];

    isHoliday = json["is_holiday"];
    if (json["is_holiday"]) {
      holidayMsg = json["message"];
    } else {
      totalCount = json["total_count"];
      absentCount = json["absent_count"];
      for (var i in json["data"]) {
        studentModel!.add(
          BaseAttendanceModel(
            admissionNumber: i["admission_number"],
            name: i["student_name"],
            standard: i["standard"],
            division: i["division"],
            reason: i["reason"] ?? "",
            isAbsent: i["is_absent"],
          ),
        );
      }
    }
  }

  AttendanceModel.withError(String error) : errorMsg = error;
}
