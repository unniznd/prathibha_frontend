import 'package:flutter/material.dart';

class AddStudentEvent {
  int branchId;
  String name, standard, division, phoneNumber, admissionNumber;
  BuildContext context;

  AddStudentEvent({
    required this.branchId,
    required this.name,
    required this.standard,
    required this.division,
    required this.phoneNumber,
    required this.admissionNumber,
    required this.context,
  });
}
