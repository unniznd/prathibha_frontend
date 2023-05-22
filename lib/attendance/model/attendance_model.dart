class BaseAttendanceModel {
  int admissionNumber;
  String name, standard, division, reason;
  bool isAbsent;

  BaseAttendanceModel({
    required this.admissionNumber,
    required this.name,
    required this.standard,
    required this.division,
    required this.reason,
    required this.isAbsent,
  });
}

class AttendanceModel {
  List<BaseAttendanceModel>? studentModel;
  int? count = 0;

  String? errorMsg;

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    studentModel = [];
    count = json["count"];
    for (var i in json["data"]) {
      studentModel!.add(BaseAttendanceModel(
        admissionNumber: i["admission_number"],
        name: i["student_name"],
        standard: i["standard"],
        division: i["division"],
        reason: i["reason"] ?? "",
        isAbsent: i["is_absent"],
      ));
    }
  }

  AttendanceModel.withError(String error) : errorMsg = error;
}
