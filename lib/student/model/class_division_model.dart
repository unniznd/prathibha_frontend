class StudentClassDivisionModel {
  List<String>? classes;
  Map<String, List<String>>? divisions;

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
  }

  StudentClassDivisionModel.withError(String error) : errorMsg = error;
}
