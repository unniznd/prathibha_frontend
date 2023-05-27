import 'package:prathibha_web/dashboard/model/attendace_detailed_model.dart';

abstract class AttendanceDetailedState {}

class AttendanceDetailedLoading extends AttendanceDetailedState {}

class AttendanceDetailedLoaded extends AttendanceDetailedState {
  final AttendanceDetailedModel attendanceDetailedModel;
  AttendanceDetailedLoaded({required this.attendanceDetailedModel});
}

class AttendanceDetailedError extends AttendanceDetailedState {
  AttendanceDetailedError({required this.message});

  final String message;
}
