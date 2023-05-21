import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:prathibha_web/student/bloc/class/class_bloc.dart';
import 'package:prathibha_web/student/bloc/class/class_event.dart';
import 'package:prathibha_web/student/bloc/class/class_state.dart';
import 'package:prathibha_web/student/bloc/division/division_bloc.dart';
import 'package:prathibha_web/student/bloc/division/division_event.dart';
import 'package:prathibha_web/student/bloc/division/division_state.dart';
import 'package:prathibha_web/student/widget/student_table_row.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key, required this.branchId});

  final int branchId;

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final StudentClassBloc studentClassBloc = StudentClassBloc();
  final StudentDivisionBloc studentDivisionBloc = StudentDivisionBloc();

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
              "Students",
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
                  color: const Color.fromRGBO(
                      234, 240, 247, 1) // Customize the border radius if needed
                  ),
              child: BlocBuilder<StudentClassBloc, ClassState>(
                bloc: studentClassBloc,
                builder: (context, state) {
                  return DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: state.className,
                      hint: const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("Class"),
                      ),
                      onChanged: (String? newValue) {
                        studentClassBloc.add(ChangeClass(className: newValue));
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
              child: BlocBuilder<StudentDivisionBloc, DivisionState>(
                bloc: studentDivisionBloc,
                builder: (context, state) {
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
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "200 Students",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                studentClassBloc.add(ChangeClass(className: null));
                studentDivisionBloc.add(ChangeDivision(divisionName: null));
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
                  StudentTableRow(
                    rowData: const [
                      'Reg No',
                      'Student Name',
                      'Actions',
                    ],
                    isHeader: true,
                  ),
                  const Divider(),
                  StudentTableRow(
                    rowData: const [
                      '01',
                      'Akhil',
                      'View',
                    ],
                  ),
                  const Divider(),
                  StudentTableRow(
                    rowData: const [
                      '02',
                      'Akhil',
                      'View',
                    ],
                  ),
                  const Divider(),
                  StudentTableRow(
                    rowData: const [
                      '03',
                      'Akhil',
                      'View',
                    ],
                  ),
                  const Divider(),
                  StudentTableRow(
                    rowData: const [
                      '04',
                      'Akhil',
                      'View',
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
