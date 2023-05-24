class BaseFeeModel {
  String feeId;
  String studentName, standard, division, feeStatus, feeDate;
  String amount;

  BaseFeeModel({
    required this.feeId,
    required this.studentName,
    required this.standard,
    required this.division,
    required this.feeStatus,
    required this.feeDate,
    required this.amount,
  });
}

class FeeModel {
  List<BaseFeeModel>? feeList;
  int? totalCount;
  int? unpaidCount;

  String? errorMsg;

  FeeModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    unpaidCount = json['unpaid_count'];
    feeList = [];

    for (var fee in json['data']) {
      feeList!.add(BaseFeeModel(
        feeId: fee['fee_id'].toString(),
        studentName: fee['student_name'],
        standard: fee['standard'],
        division: fee['division'],
        feeStatus: fee['status'],
        feeDate: fee['date_of_payment'],
        amount: fee['amount'].toString(),
      ));
    }
  }

  FeeModel.withError(String errorMsg) {
    errorMsg = errorMsg;
  }
}
