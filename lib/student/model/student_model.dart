class _BaseStudentModel {
  int admissionNumber;
  String name, standard, division, branch, phoneNumber;

  _BaseStudentModel({
    required this.admissionNumber,
    required this.name,
    required this.standard,
    required this.division,
    required this.branch,
    required this.phoneNumber,
  });
}

class StudentModel {
  // ignore: library_private_types_in_public_api
  List<_BaseStudentModel>? studentModel;
  int? count = 0;

  String? errorMsg;

  StudentModel.fromJson(Map<String, dynamic> json) {
    studentModel = [];
    count = json["count"];
    for (var i in json["data"]) {
      studentModel!.add(_BaseStudentModel(
        admissionNumber: i["admission_number"],
        name: i["student_name"],
        standard: i["standard"],
        division: i["division"],
        branch: i["branch"],
        phoneNumber: i["phone_number"],
      ));
    }
  }

  StudentModel.withError(String error) : errorMsg = error;
}
