import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api/dashboard_api.dart';
import 'attendance_overview_event.dart';
import 'attendance_overview_state.dart';

class AttendanceOverviewBloc
    extends Bloc<AttendanceOverviewEvent, AttendanceOverviewState> {
  final DashboardApiProvider dashboardApiProvider = DashboardApiProvider();
  AttendanceOverviewBloc() : super(AttendanceOverviewLoading()) {
    on<FetchAttendanceOverview>((event, emit) async {
      emit(AttendanceOverviewLoading());
      try {
        var attendanceOverview =
            await dashboardApiProvider.fetchAttendanceOverview(event.branchId);

        if (attendanceOverview.errorMsg != null) {
          emit(AttendanceOverviewError(errorMsg: attendanceOverview.errorMsg!));
        } else {
          emit(
              AttendanceOverviewLoaded(attendanceOverview: attendanceOverview));
        }
      } catch (e) {
        emit(AttendanceOverviewError(errorMsg: e.toString()));
      }
    });
  }
}
