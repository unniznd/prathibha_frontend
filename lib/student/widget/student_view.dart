import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:prathibha_web/student/bloc/add_student/add_student_event.dart';
import 'package:prathibha_web/student/bloc/class/class_bloc.dart';
import 'package:prathibha_web/student/bloc/class/class_event.dart';
import 'package:prathibha_web/student/bloc/class/class_state.dart';
import 'package:prathibha_web/student/bloc/class_divison/class_division_bloc.dart';
import 'package:prathibha_web/student/bloc/class_divison/class_division_event.dart';
import 'package:prathibha_web/student/bloc/class_divison/class_divison_state.dart';
import 'package:prathibha_web/student/bloc/division/division_bloc.dart';
import 'package:prathibha_web/student/bloc/division/division_event.dart';
import 'package:prathibha_web/student/bloc/division/division_state.dart';

void addStudentView(
  BuildContext context,
  var nameController,
  var standardController,
  var admissionNoController,
  var parentsPhoneNoController,
  var branchId,
  var addStudentBloc,
) {
  nameController.text = '';
  parentsPhoneNoController.text = '';
  admissionNoController.text = '10000';

  final StudentClassDivisionBloc studentClassDivisionBloc =
      StudentClassDivisionBloc();

  final StudentClassBloc studentClassBloc = StudentClassBloc();
  final StudentDivisionBloc studentDivisionBloc = StudentDivisionBloc();

  final formKey = GlobalKey<FormState>();

  String? selectedClass;
  String? selectedDivision;
  List<String> divisionList = [];

  studentClassDivisionBloc.add(
    ClassDivisionFetch(branchId),
  );

  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Student Details'),
      content: BlocBuilder<StudentClassDivisionBloc, ClassDivisionState>(
        bloc: studentClassDivisionBloc,
        builder: (context, classDivisionState) {
          if (classDivisionState is ClassDivisionLoaded) {
            admissionNoController.text =
                classDivisionState.classDivisionModel.nextAdmissionNumber;

            return Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: const Color.fromRGBO(234, 240, 247, 1),
                    ),
                    child: TextField(
                      controller: admissionNoController,
                      enabled: false,
                      decoration: const InputDecoration(
                        labelText: "Admission No:",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    width: 600,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: const Color.fromRGBO(234, 240, 247, 1),
                    ),
                    child: TextFormField(
                      controller: nameController,
                      textCapitalization: TextCapitalization.characters,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter student name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Name:",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    width: 600,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(234, 240, 247, 1),
                        ),
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        color: const Color.fromRGBO(234, 240, 247, 1)),
                    child: BlocBuilder<StudentClassBloc, ClassState>(
                      bloc: studentClassBloc,
                      builder: (context, state) {
                        return DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<String>(
                            value: state.className,
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a class';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 12.0,
                              ),
                              labelText: 'Class',
                            ),
                            onChanged: (String? newValue) {
                              studentClassBloc.add(
                                ChangeClass(className: newValue!),
                              );
                              selectedClass = newValue;
                              selectedDivision = null;
                              divisionList = classDivisionState
                                  .classDivisionModel
                                  .divisions![selectedClass]!;
                              studentDivisionBloc.add(
                                ChangeDivision(divisionName: null),
                              );
                            },
                            icon: const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: HeroIcon(HeroIcons.chevronDown),
                            ),
                            items: classDivisionState
                                .classDivisionModel.classes!
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
                  const SizedBox(height: 10.0),
                  Container(
                    width: 600,
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
                        return DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 12.0,
                              ),
                              labelText: 'Division',
                            ),
                            value: null,
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a division';
                              }
                              return null;
                            },
                            onChanged: (String? newValue) {
                              studentDivisionBloc.add(
                                ChangeDivision(divisionName: newValue!),
                              );
                              selectedDivision = newValue;
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
                  const SizedBox(height: 10.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: const Color.fromRGBO(234, 240, 247, 1),
                    ),
                    child: TextFormField(
                      controller: parentsPhoneNoController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter parents phone no';
                        } else if (value.length != 10) {
                          return 'Please enter valid phone no';
                        }
                        try {
                          int.parse(value);
                        } catch (e) {
                          return 'Please enter valid phone no';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Parents phone No:",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (classDivisionState is ClassDivisionError) {
            return const Center(
              child: Text("Error"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        },
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    addStudentBloc.add(
                      AddStudentEvent(
                        branchId: branchId,
                        admissionNumber: admissionNoController.text,
                        name: nameController.text,
                        standard: selectedClass!,
                        division: selectedDivision!,
                        phoneNumber: parentsPhoneNoController.text,
                        context: context,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text("Save"),
              ),
            ),
            SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
