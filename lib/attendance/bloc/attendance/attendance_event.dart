abstract class AttendanceEvent {}

class FetchAttendance extends AttendanceEvent {
  int branchId;
  final String standard, division, q, statusAttendance, date;
  FetchAttendance(
    this.branchId,
    this.standard,
    this.division,
    this.q,
    this.statusAttendance,
    this.date,
  );
}
