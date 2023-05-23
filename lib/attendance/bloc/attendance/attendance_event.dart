import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

abstract class AttendanceEvent {}

class FetchAttendance extends AttendanceEvent {
  int branchId;
  final String standard, division, q, statusAttendance, date;
  FetchAttendance(
    this.branchId,
    this.standard,
    this.division,
    this.q,
    this.statusAttendance,
    this.date,
  );
}

class MarkAttendance extends AttendanceEvent {
  int branchId;
  int index;
  String date;
  BuildContext context;
  MarkAttendance(
    this.branchId,
    this.index,
    this.date,
    this.context,
  );
}
