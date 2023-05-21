import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:prathibha_web/attendance/bloc/absent/absent_bloc.dart';
import 'package:prathibha_web/attendance/bloc/absent/absent_event.dart';
import 'package:prathibha_web/attendance/bloc/absent/absent_state.dart';
import 'package:prathibha_web/attendance/bloc/class/class_bloc.dart';
import 'package:prathibha_web/attendance/bloc/class/class_event.dart';
import 'package:prathibha_web/attendance/bloc/class/class_state.dart';
import 'package:prathibha_web/attendance/bloc/date/date_bloc.dart';
import 'package:prathibha_web/attendance/bloc/date/date_event.dart';
import 'package:prathibha_web/attendance/bloc/date/date_state.dart';
import 'package:prathibha_web/attendance/bloc/division/division_bloc.dart';
import 'package:prathibha_web/attendance/bloc/division/division_event.dart';
import 'package:prathibha_web/attendance/bloc/division/division_state.dart';
import 'package:prathibha_web/attendance/bloc/present/present_bloc.dart';
import 'package:prathibha_web/attendance/bloc/present/present_event.dart';
import 'package:prathibha_web/attendance/bloc/present/present_state.dart';
import 'package:prathibha_web/attendance/widget/attendance_table_row.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key, required this.branchId});

  final int branchId;

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final AttendanceClassBloc attendanceClassBloc = AttendanceClassBloc();
  final AttendanceDivisionBloc divisionBloc = AttendanceDivisionBloc();
  final AbsentBloc absentBloc = AbsentBloc();
  final PresentBloc presentBloc = PresentBloc();
  final DateBloc dateBloc = DateBloc();

  String selectedDate = "Today";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Attendance Details",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Tooltip(
              message: 'Reload the table',
              child: HeroIcon(
                HeroIcons.arrowPath,
                size: 28,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: TextFormField(
            decoration: const InputDecoration(
              hintText: "Search by Student Name, Class, Section, Roll No.",
              filled: true,
              fillColor: Color.fromRGBO(234, 240, 247, 1),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Transform.scale(
              scale: 1.2,
              child: BlocBuilder<AbsentBloc, AbsentState>(
                bloc: absentBloc,
                builder: (context, state) {
                  return Checkbox(
                    value: state.isActive,
                    onChanged: (newState) {
                      if (newState == true) {
                        presentBloc.add(UpdatePresent(isActive: false));
                      }
                      absentBloc.add(UpdateAbsent(isActive: !state.isActive));
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: const Color.fromRGBO(68, 97, 242, 1),
                  );
                },
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "Absent",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Transform.scale(
              scale: 1.2,
              child: BlocBuilder<PresentBloc, PresentState>(
                bloc: presentBloc,
                builder: (context, state) {
                  return Checkbox(
                    value: state.isActive,
                    onChanged: (newState) {
                      if (newState == true) {
                        absentBloc.add(UpdateAbsent(isActive: false));
                      }
                      presentBloc.add(UpdatePresent(isActive: !state.isActive));
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: const Color.fromRGBO(68, 97, 242, 1),
                  );
                },
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "Present",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              width: 120,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(234, 240, 247, 1),
                  ), // Customize the border color and other properties
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  color: const Color.fromRGBO(
                      234, 240, 247, 1) // Customize the border radius if needed
                  ),
              child: BlocBuilder<AttendanceClassBloc, ClassState>(
                bloc: attendanceClassBloc,
                builder: (context, state) {
                  return DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: state.className,
                      hint: const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("Class"),
                      ),
                      onChanged: (String? newValue) {
                        attendanceClassBloc
                            .add(ChangeClass(className: newValue));
                      },
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: HeroIcon(HeroIcons.chevronDown),
                      ),
                      items: <String>[
                        '10',
                        '9',
                        '8',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              value,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 120,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(234, 240, 247, 1),
                  ), // Customize the border color and other properties
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  color: const Color.fromRGBO(
                      234, 240, 247, 1) // Customize the border radius if needed
                  ),
              child: BlocBuilder<AttendanceDivisionBloc, DivisionState>(
                bloc: divisionBloc,
                builder: (context, state) {
                  return DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: state.divisionName,
                      hint: const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("Division"),
                      ),
                      onChanged: (String? newValue) {
                        divisionBloc
                            .add(ChangeDivision(divisionName: newValue));
                      },
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: HeroIcon(HeroIcons.chevronDown),
                      ),
                      items: <String>[
                        'A',
                        'B',
                        'C',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              value,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              // width: 200,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const HeroIcon(HeroIcons.sparkles),
                label: const Text("Mark As Holiday"),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              // width: 120,
              height: 50,
              child: BlocBuilder<DateBloc, DateState>(
                bloc: dateBloc,
                builder: (context, state) {
                  if (state is DateChanged) {
                    selectedDate = DateFormat('MMMM d').format(
                      state.date,
                    );

                    if (state.date.day == DateTime.now().day &&
                        state.date.month == DateTime.now().month &&
                        state.date.year == DateTime.now().year) {
                      selectedDate = "Today";
                    }
                  }
                  return ElevatedButton.icon(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate!.isAfter(DateTime.now())) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                            width: 700,
                            content: Row(
                              children: const [
                                HeroIcon(
                                  HeroIcons.exclamationCircle,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Date cannot be in future",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                        return;
                      }
                      if (pickedDate != null) {
                        dateBloc.add(ChangeDate(pickedDate));
                      }
                    },
                    icon: const HeroIcon(HeroIcons.calendar),
                    label: Text(selectedDate),
                  );
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "1 of 4 Absent Students",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                attendanceClassBloc.add(ChangeClass(className: null));
                divisionBloc.add(ChangeDivision(divisionName: null));
                dateBloc.add(ChangeDate(DateTime.now()));
              },
              child: const Text("Clear Filters"),
            )
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.9,
              child: Column(
                children: [
                  AttendanceTableRow(
                    rowData: [
                      Checkbox(value: true, onChanged: (value) {}),
                      'Student Name',
                      'Status',
                      'Reason',
                    ],
                    isHeader: true,
                  ),
                  const Divider(),
                  AttendanceTableRow(
                    rowData: [
                      Checkbox(value: true, onChanged: (value) {}),
                      'Akhil',
                      'Present',
                      'Reason',
                    ],
                  ),
                  const Divider(),
                  AttendanceTableRow(
                    rowData: [
                      Checkbox(value: true, onChanged: (value) {}),
                      'Akhil',
                      'Present',
                      'Reason',
                    ],
                  ),
                  const Divider(),
                  AttendanceTableRow(
                    rowData: [
                      Checkbox(value: true, onChanged: (value) {}),
                      'Akhil',
                      'Absent',
                      'Reason',
                    ],
                  ),
                  const Divider(),
                  AttendanceTableRow(
                    rowData: [
                      Checkbox(value: true, onChanged: (value) {}),
                      'Akhil',
                      'Present',
                      'Reason',
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
