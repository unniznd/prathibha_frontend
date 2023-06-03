import 'package:flutter/material.dart';

abstract class AttendanceDetailedEvent {}

class FetchAttendanceDetailed extends AttendanceDetailedEvent {
  int branchId;
  String standard, division;

  FetchAttendanceDetailed({
    required this.branchId,
    required this.standard,
    required this.division,
  });
}

class NotifyAbsentees extends AttendanceDetailedEvent {
  int branchId;
  String standard, division;
  BuildContext context;

  NotifyAbsentees({
    required this.branchId,
    required this.standard,
    required this.division,
    required this.context,
  });
}
