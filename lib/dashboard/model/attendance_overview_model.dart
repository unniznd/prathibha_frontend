class BaseAttendanceOverview {
  String standardDivision;
  int totalStudents;
  int totalPresent;

  BaseAttendanceOverview({
    required this.standardDivision,
    required this.totalStudents,
    required this.totalPresent,
  });
}

class AttendanceOverview {
  List<BaseAttendanceOverview>? attendanceOverviewList;

  String? errorMsg;

  AttendanceOverview.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;

    // Iterate over each key-value pair in the 'data' object
    attendanceOverviewList = [];
    for (var key in data.keys) {
      final value = data[key] as Map<String, dynamic>;
      attendanceOverviewList!.add(BaseAttendanceOverview(
        standardDivision: key,
        totalStudents: value['total'],
        totalPresent: value['present'],
      ));
    }
  }

  AttendanceOverview.withError(String errorMessage) {
    errorMsg = errorMessage;
  }
}
