import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:prathibha_web/dashboard/bloc/attendance_detailed/attendance_detailed_bloc.dart';
import 'package:prathibha_web/dashboard/model/attendace_detailed_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prathibha_web/dashboard/bloc/attendance_detailed/attendance_detailed_event.dart';
import 'package:prathibha_web/dashboard/bloc/attendance_detailed/attendance_detailed_state.dart';

void viewAbsenteesDialog({
  required BuildContext context,
  required int branchId,
  required String standard,
  required String division,
  required var attendanceDetailedBloc,
}) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      title: const Align(
        alignment: Alignment.center,
        child: Text(
          "Today's Absentees",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      content: Builder(
        builder: (context) {
          List<BaseAttendanceDetailedModel> students = [];
          attendanceDetailedBloc.add(
            FetchAttendanceDetailed(
              branchId: branchId,
              standard: standard,
              division: division,
            ),
          );
          return SizedBox(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  BlocBuilder<AttendanceDetailedBloc, AttendanceDetailedState>(
                    bloc: attendanceDetailedBloc,
                    builder: (context, state) {
                      if (state is AttendanceDetailedLoaded) {
                        if (state.attendanceDetailedModel.students!.isEmpty) {
                          return const Center(
                            child: Text("No Absentees"),
                          );
                        }
                        students = state.attendanceDetailedModel.students!;
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: const [
                              DataColumn(
                                label: Text(
                                  'Roll Number',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Student Name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Phone Number',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                            rows: students
                                .map((e) => DataRow(cells: [
                                      DataCell(
                                        Text(e.rollNumber.toString()),
                                      ),
                                      DataCell(
                                        Text(e.name.toString()),
                                      ),
                                      DataCell(
                                        Text(e.phoneNumber.toString()),
                                      ),
                                    ]))
                                .toList(),
                          ),
                        );
                      } else if (state is AttendanceDetailedError) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 150,
                  height: 30,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Send SMS"),
                            content:
                                const Text("Are you sure you want to send SMS"),
                            actions: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    backgroundColor:
                                        const Color.fromARGB(255, 255, 136, 67),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20), // Set border radius
                                    ),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: const Text("Cancel"),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    bottom: 10, right: 10),
                                child: ElevatedButton(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: const Text("Send"),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    attendanceDetailedBloc.add(
                                      NotifyAbsentees(
                                        branchId: branchId,
                                        standard: standard,
                                        division: division,
                                        context: context,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const HeroIcon(HeroIcons.envelope),
                    label: const Text("Send SMS"),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 150,
                  height: 30,
                  child: ElevatedButton.icon(
                    icon: const HeroIcon(HeroIcons.xMark),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    label: const Text("Close"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
