import 'package:flutter_bloc/flutter_bloc.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';
import 'package:prathibha_web/attendance/api/attendace_api.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceApiProvider attendanceApiProvider = AttendanceApiProvider();
  AttendanceBloc() : super(AttendanceLoading()) {
    on<FetchAttendance>((event, emit) async {
      emit(AttendanceLoading());
      // try {
      final attendanceModel = await attendanceApiProvider.fetchStudentDetails(
        event.branchId,
        event.standard,
        event.division,
        event.q,
        event.statusAttendance,
        event.date,
      );
      if (attendanceModel.errorMsg != null) {
        emit(AttendanceError(errorMsg: attendanceModel.errorMsg!));
      } else {
        emit(AttendanceLoaded(attendanceModel: attendanceModel));
      }
      // } catch (e) {
      //   emit(AttendanceError(errorMsg: e.toString()));
      // }
    });
  }
}
