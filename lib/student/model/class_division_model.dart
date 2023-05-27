class StudentClassDivisionModel {
  List<String>? classes;
  Map<String, List<String>>? divisions;
  List<String>? installments;
  String? nextAdmissionNumber;

  String? errorMsg;

  StudentClassDivisionModel.fromJson(Map<String, dynamic> json) {
    classes = [];
    divisions = {};
    for (var i in json["data"][0]) {
      classes!.add(i.toString());
    }
    // json["data"][1] is a map
    for (var i in json["data"][1].keys) {
      divisions![i.toString()] = [];
      for (var j in json["data"][1][i]) {
        divisions![i.toString()]!.add(j.toString());
      }
    }
    installments = [];
    for (var i in json["data"][2]) {
      installments!.add(i.toString());
    }
    nextAdmissionNumber = json["data"][3].toString();
  }

  StudentClassDivisionModel.withError(String error) : errorMsg = error;
}
