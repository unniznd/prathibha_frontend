import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:prathibha_web/student/bloc/class/class_bloc.dart';
import 'package:prathibha_web/student/bloc/class/class_event.dart';
import 'package:prathibha_web/student/bloc/class/class_state.dart';
import 'package:prathibha_web/student/bloc/class_divison/class_division_bloc.dart';
import 'package:prathibha_web/student/bloc/class_divison/class_division_event.dart';
import 'package:prathibha_web/student/bloc/class_divison/class_divison_state.dart';
import 'package:prathibha_web/student/bloc/division/division_bloc.dart';
import 'package:prathibha_web/student/bloc/division/division_event.dart';
import 'package:prathibha_web/student/bloc/division/division_state.dart';
import 'package:prathibha_web/student/bloc/student/student_bloc.dart';
import 'package:prathibha_web/student/bloc/student/student_event.dart';
import 'package:prathibha_web/student/bloc/student/student_state.dart';
import 'package:prathibha_web/student/widget/student_table_row.dart';
import 'package:shimmer/shimmer.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key, required this.branchId});

  final int branchId;

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final StudentClassBloc studentClassBloc = StudentClassBloc();
  final StudentDivisionBloc studentDivisionBloc = StudentDivisionBloc();
  final StudentClassDivisionBloc studentClassDivisionBloc =
      StudentClassDivisionBloc();
  final StudentBloc studentBloc = StudentBloc();

  String? selectedClass;
  String? selectedDivision;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    studentClassDivisionBloc.add(ClassDivisionFetch(widget.branchId));
    studentBloc.add(FetchStudentDetails(widget.branchId, "", ""));

    List<String> divisionList = [];

    return BlocBuilder<StudentClassDivisionBloc, ClassDivisionState>(
      bloc: studentClassDivisionBloc,
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
                    "Students",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Tooltip(
                    message: 'Reload the table',
                    child: GestureDetector(
                      onTap: () {
                        studentBloc.add(
                          FetchStudentDetails(widget.branchId,
                              selectedClass ?? "", selectedDivision ?? ""),
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
                  decoration: const InputDecoration(
                    hintText: "Search by Reg No. and Name",
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
                    child: BlocBuilder<StudentClassBloc, ClassState>(
                      bloc: studentClassBloc,
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
                              studentClassBloc
                                  .add(ChangeClass(className: newValue));
                              divisionList = classDivsionstate
                                  .classDivisionModel.divisions![newValue]!;

                              studentDivisionBloc.add(
                                ChangeDivision(
                                  divisionName: null,
                                ),
                              );
                              studentBloc.add(
                                FetchStudentDetails(
                                  widget.branchId,
                                  newValue ?? "",
                                  "",
                                ),
                              );
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
                    child: BlocBuilder<StudentDivisionBloc, DivisionState>(
                      bloc: studentDivisionBloc,
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
                              studentDivisionBloc
                                  .add(ChangeDivision(divisionName: newValue));
                              studentBloc.add(
                                FetchStudentDetails(
                                  widget.branchId,
                                  selectedClass ?? "",
                                  newValue ?? "",
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
                    height: 20,
                    width: 10,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<StudentBloc, StudentState>(
                    bloc: studentBloc,
                    builder: (context, state) {
                      if (state is StudentLoaded) {
                        return Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: state.studentModel.studentModel!.length > 1
                                ? Text(
                                    "${state.studentModel.studentModel!.length} Students",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  )
                                : Text(
                                    "${state.studentModel.studentModel!.length} Student",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ));
                      } else if (state is StudentError) {
                        return const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "0 Students",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: SizedBox(
                                width: 50,
                                height: 16.0, // Adjust the height as needed
                                child: Container(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Text(
                              " Students",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      divisionList = [];
                      studentClassBloc.add(ChangeClass(className: null));
                      studentDivisionBloc
                          .add(ChangeDivision(divisionName: null));
                      studentBloc
                          .add(FetchStudentDetails(widget.branchId, "", ""));
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
                    width: MediaQuery.of(context).size.width / 1.8,
                    child: Column(
                      children: [
                        const StudentTableRow(
                          rowData: [
                            'Admission No',
                            'Student Name',
                            'Class Division',
                            'Actions',
                          ],
                          isHeader: true,
                        ),
                        const Divider(),
                        BlocBuilder<StudentBloc, StudentState>(
                          bloc: studentBloc,
                          builder: (context, state) {
                            if (state is StudentLoaded) {
                              return ListView.separated(
                                shrinkWrap: true,
                                itemCount:
                                    state.studentModel.studentModel!.length,
                                separatorBuilder: (context, index) {
                                  return const Divider();
                                },
                                itemBuilder: (context, index) {
                                  return StudentTableRow(
                                    rowData: [
                                      state.studentModel.studentModel![index]
                                          .admissionNumber
                                          .toString(),
                                      state.studentModel.studentModel![index]
                                          .name
                                          .toString(),
                                      "${state.studentModel.studentModel![index].standard.toString()} ${state.studentModel.studentModel![index].division.toString()}",
                                      'View',
                                    ],
                                  );
                                },
                              );
                            } else if (state is StudentError) {
                              return Center(
                                child: Text(state.error),
                              );
                            }
                            return ListView.separated(
                              shrinkWrap: true,
                              itemCount: 10,
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                              itemBuilder: (context, index) {
                                return const StudentTableRow(
                                  rowData: [
                                    "1",
                                    "2",
                                    "3",
                                    "4",
                                  ],
                                  isShimmer: true,
                                );
                              },
                            );
                          },
                        )
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
