abstract class AttendanceOverviewEvent {}

class FetchAttendanceOverview extends AttendanceOverviewEvent {
  final int branchId;

  FetchAttendanceOverview({
    required this.branchId,
  });
}
