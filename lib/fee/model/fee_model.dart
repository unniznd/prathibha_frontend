class BaseFeeModel {
  int feeId;

  String admissionNumber, studentName, standard, division, feeStatus, feeDate;
  String totalAmount, amountLeft, installment;
  bool isMarkingFee;

  BaseFeeModel({
    required this.feeId,
    required this.admissionNumber,
    required this.studentName,
    required this.standard,
    required this.division,
    required this.feeStatus,
    required this.feeDate,
    required this.totalAmount,
    required this.amountLeft,
    required this.installment,
    this.isMarkingFee = false,
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
        feeId: fee['fee_id'],
        admissionNumber: fee['admission_number'],
        studentName: fee['student_name'],
        standard: fee['standard'],
        division: fee['division'],
        feeStatus: fee['status'],
        feeDate: fee['date_of_payment'],
        totalAmount: fee['amount'].toString(),
        amountLeft: fee['amount_left'].toString(),
        installment: fee['installment'],
      ));
    }
  }

  FeeModel.withError(String errorMsg) {
    errorMsg = errorMsg;
  }
}
