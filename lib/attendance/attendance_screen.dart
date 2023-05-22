import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:prathibha_web/attendance/bloc/absent/absent_bloc.dart';
import 'package:prathibha_web/attendance/bloc/absent/absent_event.dart';
import 'package:prathibha_web/attendance/bloc/absent/absent_state.dart';
import 'package:prathibha_web/attendance/bloc/attendance/attendance_bloc.dart';
import 'package:prathibha_web/attendance/bloc/attendance/attendance_event.dart';
import 'package:prathibha_web/attendance/bloc/attendance/attendance_state.dart';
import 'package:prathibha_web/attendance/bloc/class/class_bloc.dart';
import 'package:prathibha_web/attendance/bloc/class/class_event.dart';
import 'package:prathibha_web/attendance/bloc/class/class_state.dart';
import 'package:prathibha_web/attendance/bloc/class_divison/class_division_bloc.dart';
import 'package:prathibha_web/attendance/bloc/class_divison/class_division_event.dart';
import 'package:prathibha_web/attendance/bloc/class_divison/class_divison_state.dart';
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
  final AttendanceBloc attendanceBloc = AttendanceBloc();
  final AttendanceClassDivisionBloc attendanceClassDivisionBloc =
      AttendanceClassDivisionBloc();

  final TextEditingController searchController = TextEditingController();

  String selectedDate = "Today";

  String? selectedClass;
  String? selectedDivision;
  String? attendanceStatus;

  bool isAbsentChecked = false;
  bool isPresentChecked = false;

  @override
  Widget build(BuildContext context) {
    attendanceClassDivisionBloc.add(ClassDivisionFetch(widget.branchId));
    attendanceBloc.add(FetchAttendance(widget.branchId, "", "", "", ""));
    attendanceClassBloc.add(ChangeClass(className: null));
    absentBloc.add(UpdateAbsent(isActive: false));
    presentBloc.add(UpdatePresent(isActive: false));

    List<String> divisionList = [];

    return BlocBuilder<AttendanceClassDivisionBloc, ClassDivisionState>(
      bloc: attendanceClassDivisionBloc,
      builder: (context, classDivsionstate) {
        if (classDivsionstate is ClassDivisionLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Attendance Details",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Tooltip(
                    message: 'Reload the table',
                    child: GestureDetector(
                      onTap: () {
                        attendanceBloc.add(
                          FetchAttendance(
                            widget.branchId,
                            selectedClass ?? "",
                            selectedDivision ?? "",
                            searchController.text,
                            attendanceStatus ?? "",
                          ),
                        );
                      },
                      child: const HeroIcon(
                        HeroIcons.arrowPath,
                        size: 28,
                      ),
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
                  controller: searchController,
                  onChanged: (value) {
                    attendanceBloc.add(
                      FetchAttendance(
                        widget.branchId,
                        selectedClass ?? "",
                        selectedDivision ?? "",
                        value,
                        attendanceStatus ?? "",
                      ),
                    );
                  },
                  decoration: const InputDecoration(
                    hintText: "Search by Student Name",
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
                              isPresentChecked = false;
                            }
                            absentBloc
                                .add(UpdateAbsent(isActive: !state.isActive));
                            isAbsentChecked = !state.isActive;

                            attendanceStatus = isAbsentChecked
                                ? "absent"
                                : isPresentChecked
                                    ? "present"
                                    : "";
                            attendanceBloc.add(
                              FetchAttendance(
                                widget.branchId,
                                selectedClass ?? "",
                                selectedDivision ?? "",
                                searchController.text,
                                attendanceStatus ?? "",
                              ),
                            );
                          },
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
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
                              isAbsentChecked = false;
                            }
                            presentBloc
                                .add(UpdatePresent(isActive: !state.isActive));

                            isPresentChecked = !state.isActive;

                            attendanceStatus = isAbsentChecked
                                ? "absent"
                                : isPresentChecked
                                    ? "present"
                                    : "";
                            attendanceBloc.add(
                              FetchAttendance(
                                widget.branchId,
                                selectedClass ?? "",
                                selectedDivision ?? "",
                                searchController.text,
                                attendanceStatus ?? "",
                              ),
                            );
                          },
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
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
                        color: const Color.fromRGBO(234, 240, 247,
                            1) // Customize the border radius if needed
                        ),
                    child: BlocBuilder<AttendanceClassBloc, ClassState>(
                      bloc: attendanceClassBloc,
                      builder: (context, state) {
                        selectedClass = state.className;
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

                              divisionList = classDivsionstate
                                  .classDivisionModel.divisions![newValue]!;
                              divisionBloc
                                  .add(ChangeDivision(divisionName: null));
                              attendanceBloc.add(FetchAttendance(
                                widget.branchId,
                                newValue ?? "",
                                "",
                                searchController.text,
                                attendanceStatus ?? "",
                              ));
                            },
                            icon: const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: HeroIcon(HeroIcons.chevronDown),
                            ),
                            items: classDivsionstate.classDivisionModel.classes!
                                .map((String value) {
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
                        color: const Color.fromRGBO(234, 240, 247,
                            1) // Customize the border radius if needed
                        ),
                    child: BlocBuilder<AttendanceDivisionBloc, DivisionState>(
                      bloc: divisionBloc,
                      builder: (context, state) {
                        selectedDivision = state.divisionName;
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
                              attendanceBloc.add(
                                FetchAttendance(
                                  widget.branchId,
                                  selectedClass ?? "",
                                  newValue ?? "",
                                  searchController.text,
                                  attendanceStatus ?? "",
                                ),
                              );
                            },
                            icon: const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: HeroIcon(HeroIcons.chevronDown),
                            ),
                            items: divisionList.map((String value) {
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
                      presentBloc.add(UpdatePresent(isActive: false));
                      absentBloc.add(UpdateAbsent(isActive: false));
                      attendanceBloc.add(
                        FetchAttendance(
                          widget.branchId,
                          "",
                          "",
                          "",
                          "",
                        ),
                      );
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
                            Checkbox(value: false, onChanged: (value) {}),
                            'Admission No',
                            'Student Name',
                            'Class Division',
                            'Status',
                            'Reason',
                          ],
                          isHeader: true,
                        ),
                        BlocBuilder<AttendanceBloc, AttendanceState>(
                          bloc: attendanceBloc,
                          builder: (context, state) {
                            if (state is AttendanceLoaded) {
                              if (state.attendanceModel.studentModel!.isEmpty) {
                                return Column(
                                  children: const [
                                    SizedBox(
                                      height: 50,
                                    ),
                                    // no report to view
                                    HeroIcon(
                                      HeroIcons.userGroup,
                                      size: 100,
                                      color: Color.fromRGBO(233, 233, 233, 1),
                                    ),
                                    Center(
                                      child: Text(
                                        " No Students Found",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(194, 194, 194, 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return ListView.separated(
                                itemCount:
                                    state.attendanceModel.studentModel!.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return AttendanceTableRow(
                                    rowData: [
                                      Checkbox(
                                          value: false, onChanged: (value) {}),
                                      state.attendanceModel.studentModel![index]
                                          .admissionNumber
                                          .toString(),
                                      state.attendanceModel.studentModel![index]
                                          .name,
                                      "${state.attendanceModel.studentModel![index].standard} ${state.attendanceModel.studentModel![index].division}",
                                      state.attendanceModel.studentModel![index]
                                              .isAbsent
                                          ? "Absent"
                                          : "Present",
                                      state.attendanceModel.studentModel![index]
                                          .reason,
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider();
                                },
                              );
                            } else if (state is AttendanceError) {
                              return Center(
                                child: Text(state.errorMsg),
                              );
                            }
                            return ListView.separated(
                              itemCount: 15,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return AttendanceTableRow(
                                  rowData: const ["1", "2", "3", "4", "5"],
                                  isShimmer: true,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (classDivsionstate is ClassDivisionError) {
          return Center(
            child: Text(classDivsionstate.error),
          );
        }
        return Center(
          child: Image.asset(
            "assets/images/loading.gif",
            width: 100,
          ),
        );
      },
    );
  }
}
