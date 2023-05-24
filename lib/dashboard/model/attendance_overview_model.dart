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
    attendanceOverviewList = data.entries.map((entry) {
      final standardDivision = entry.key;
      final totalStudents = entry.value['total'] as int;
      final totalPresent = entry.value['present'] as int;

      return BaseAttendanceOverview(
        standardDivision: standardDivision,
        totalStudents: totalStudents,
        totalPresent: totalPresent,
      );
    }).toList();
  }

  AttendanceOverview.withError(String errorMessage) {
    errorMsg = errorMessage;
  }
}
