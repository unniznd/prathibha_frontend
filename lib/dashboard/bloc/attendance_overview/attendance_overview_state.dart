import 'package:prathibha_web/dashboard/model/attendance_overview_model.dart';

abstract class AttendanceOverviewState {}

class AttendanceOverviewLoading extends AttendanceOverviewState {}

class AttendanceOverviewLoaded extends AttendanceOverviewState {
  final AttendanceOverview attendanceOverview;
  AttendanceOverviewLoaded({
    required this.attendanceOverview,
  });
}

class AttendanceOverviewError extends AttendanceOverviewState {
  final String errorMsg;
  AttendanceOverviewError({
    required this.errorMsg,
  });
}
