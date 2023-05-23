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

class MarkAbsentAttendance extends AttendanceEvent {
  int branchId;
  int index;
  String date;
  BuildContext context;
  bool isPresentChecked;
  MarkAbsentAttendance(
    this.branchId,
    this.index,
    this.date,
    this.context,
    this.isPresentChecked,
  );
}

class MarkPresentAttendance extends AttendanceEvent {
  int branchId;
  int index;
  String date;
  BuildContext context;
  bool isAbsentChecked;
  MarkPresentAttendance(
    this.branchId,
    this.index,
    this.date,
    this.context,
    this.isAbsentChecked,
  );
}
