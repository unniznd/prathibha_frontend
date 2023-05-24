import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api/dashboard_api.dart';
import 'dashboard_summary_event.dart';
import 'dashboard_summary_state.dart';

class DashboardSummaryBloc
    extends Bloc<FetchDashboardSummary, DashboardSummaryState> {
  final DashboardApiProvider dashboardApiProvider = DashboardApiProvider();
  DashboardSummaryBloc() : super(DashboardSummaryLoading()) {
    on<FetchDashboardSummary>((event, emit) async {
      emit(DashboardSummaryLoading());
      try {
        var dashboardSummary =
            await dashboardApiProvider.fetchDashboardSummary(event.branchId);

        if (dashboardSummary.errorMsg != null) {
          emit(DashboardSummaryError(errorMsg: dashboardSummary.errorMsg!));
        } else {
          emit(DashboardSummaryLoaded(dashboardSummaryModel: dashboardSummary));
        }
      } catch (e) {
        emit(DashboardSummaryError(errorMsg: e.toString()));
      }
    });
  }
}
