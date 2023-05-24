import 'package:prathibha_web/dashboard/model/dashboard_summary_model.dart';

abstract class DashboardSummaryState {}

class DashboardSummaryLoading extends DashboardSummaryState {}

class DashboardSummaryLoaded extends DashboardSummaryState {
  final DashboardSummaryModel dashboardSummaryModel;
  DashboardSummaryLoaded({
    required this.dashboardSummaryModel,
  });
}

class DashboardSummaryError extends DashboardSummaryState {
  final String errorMsg;
  DashboardSummaryError({
    required this.errorMsg,
  });
}
