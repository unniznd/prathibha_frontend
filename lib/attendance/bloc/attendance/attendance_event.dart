import 'package:flutter/cupertino.dart';

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

class MarkAsHoliday extends AttendanceEvent {
  int branchId;
  String date;
  BuildContext context;
  MarkAsHoliday(this.branchId, this.date, this.context);
}

class UnmarkAsHoliday extends AttendanceEvent {
  int branchId;
  String date;
  BuildContext context;
  UnmarkAsHoliday(this.branchId, this.date, this.context);
}
