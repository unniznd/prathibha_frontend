class DashboardSummaryModel {
  int? totalStudents;
  int? totalPaid;
  int? totalUnpaid;

  String? errorMsg;

  DashboardSummaryModel.fromJson(Map<String, dynamic> json) {
    totalStudents = json['total_students'];
    totalPaid = json['total_fee_paid'];
    totalUnpaid = json['total_fee_unpaid'];
  }

  DashboardSummaryModel.withError(String errorMessage) {
    errorMsg = errorMessage;
  }
}
