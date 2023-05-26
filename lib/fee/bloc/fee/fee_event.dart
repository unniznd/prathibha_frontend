import 'package:flutter/material.dart';

abstract class FeeEvent {}

class FetchFee extends FeeEvent {
  final int branchId;
  final String standard, division, month, status, q;
  FetchFee({
    required this.branchId,
    required this.standard,
    required this.division,
    required this.month,
    required this.status,
    required this.q,
  });
}

class MarkAsPaidAndUnpaid extends FeeEvent {
  final int branchId;
  final int feeId;
  final int index;
  final String amountPaid;
  final BuildContext context;
  final bool isUnpaidChecked, isPaidChecked;

  MarkAsPaidAndUnpaid({
    required this.branchId,
    required this.feeId,
    required this.index,
    required this.amountPaid,
    required this.context,
    required this.isPaidChecked,
    required this.isUnpaidChecked,
  });
}
