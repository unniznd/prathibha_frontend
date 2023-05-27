import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:prathibha_web/dashboard/api/dashboard_api.dart';
import 'package:prathibha_web/dashboard/model/attendace_detailed_model.dart';
import 'attendance_detailed_event.dart';
import 'attendance_detailed_state.dart';

class AttendanceDetailedBloc
    extends Bloc<FetchAttendanceDetailed, AttendanceDetailedState> {
  final DashboardApiProvider dashboardApiProvider = DashboardApiProvider();
  AttendanceDetailedBloc() : super(AttendanceDetailedLoading()) {
    on<FetchAttendanceDetailed>((event, emit) async {
      emit(AttendanceDetailedLoading());

      try {
        final AttendanceDetailedModel attendanceDetailedModel =
            await dashboardApiProvider.detailedAttendance(
          event.branchId,
          event.standard,
          event.division,
        );
        if (attendanceDetailedModel.errorMsg != null) {
          emit(AttendanceDetailedError(message: "No students found"));
        } else {
          emit(
            AttendanceDetailedLoaded(
                attendanceDetailedModel: attendanceDetailedModel),
          );
        }
      } catch (e) {
        emit(AttendanceDetailedError(message: e.toString()));
      }
    });
  }
}
