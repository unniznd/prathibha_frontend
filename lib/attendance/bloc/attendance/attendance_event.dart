abstract class AttendanceEvent {}

class FetchAttendance extends AttendanceEvent {
  int branchId;
  final String standard, division, q, statusAttendance;
  FetchAttendance(
    this.branchId,
    this.standard,
    this.division,
    this.q,
    this.statusAttendance,
  );
}
