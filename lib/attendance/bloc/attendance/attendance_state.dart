import 'package:prathibha_web/attendance/model/attendance_model.dart';

abstract class AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final AttendanceModel attendanceModel;
  AttendanceLoaded({required this.attendanceModel});
}

class AttendanceError extends AttendanceState {
  final String errorMsg;
  AttendanceError({required this.errorMsg});
}
