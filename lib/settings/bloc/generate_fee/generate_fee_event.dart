import 'package:flutter/material.dart';

class GenerateFeeEvent {
  int branchId;
  String installment;
  Map standardFee;
  BuildContext context;

  GenerateFeeEvent({
    required this.branchId,
    required this.installment,
    required this.standardFee,
    required this.context,
  });
}
