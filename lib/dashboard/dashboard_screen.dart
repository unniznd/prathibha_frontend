import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prathibha_web/dashboard/bloc/attendance_overview/attendance_overview_bloc.dart';
import 'package:prathibha_web/dashboard/bloc/attendance_overview/attendance_overview_event.dart';
import 'package:prathibha_web/dashboard/bloc/attendance_overview/attendance_overview_state.dart';
import 'package:prathibha_web/dashboard/bloc/dashboard_summary/dashboard_summary_bloc.dart';
import 'package:prathibha_web/dashboard/bloc/dashboard_summary/dashboard_summary_event.dart';
import 'package:prathibha_web/dashboard/bloc/dashboard_summary/dashboard_summary_state.dart';
import 'package:prathibha_web/dashboard/widget/attendance_detailed.dart';
import 'package:prathibha_web/dashboard/widget/dashboard_summary_card.dart';
import 'package:prathibha_web/dashboard/widget/dashboard_table_row.dart';
import 'package:prathibha_web/dashboard/bloc/attendance_detailed/attendance_detailed_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.branchId});

  final int branchId;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardSummaryBloc dashboardSummaryBloc = DashboardSummaryBloc();
  final AttendanceOverviewBloc attendanceOverviewBloc =
      AttendanceOverviewBloc();

  final AttendanceDetailedBloc attendanceDetailedBloc =
      AttendanceDetailedBloc();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double ratioHeight = 900 / MediaQuery.of(context).size.height;
    dashboardSummaryBloc.add(FetchDashboardSummary(widget.branchId));
    attendanceOverviewBloc.add(
      FetchAttendanceOverview(
        branchId: widget.branchId,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BlocBuilder<DashboardSummaryBloc, DashboardSummaryState>(
          bloc: dashboardSummaryBloc,
          builder: (context, state) {
            if (state is DashboardSummaryLoaded) {
              return DashboardSummaryCard(
                totalStudents:
                    state.dashboardSummaryModel.totalStudents.toString(),
                totalPaid: state.dashboardSummaryModel.totalPaid.toString(),
                totalDue: state.dashboardSummaryModel.totalUnpaid.toString(),
                ratioWidth: screenWidth,
                ratioHeight: ratioHeight,
              );
            } else if (state is DashboardSummaryError) {
              return Center(
                child: Text(state.errorMsg),
              );
            } else {
              return DashboardSummaryCard(
                totalStudents: "",
                totalPaid: "",
                totalDue: "",
                ratioWidth: screenWidth,
                ratioHeight: ratioHeight,
                isLoading: true,
              );
            }
          },
        ),
        const SizedBox(height: 30),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Today's Attendance Overview",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.67,
              child: Column(
                children: [
                  DashboardTableRow(
                    rowData: const [
                      'Sl No.',
                      'Class Division',
                      'Present',
                      'Total',
                      'Actions'
                    ],
                    onAbsenteesView: null,
                    isHeader: true,
                  ),
                  BlocBuilder<AttendanceOverviewBloc, AttendanceOverviewState>(
                    bloc: attendanceOverviewBloc,
                    builder: (context, state) {
                      if (state is AttendanceOverviewLoaded) {
                        if (state.attendanceOverview.attendanceOverviewList!
                            .isEmpty) {
                          return const Center(
                            child: Text("No Data Found"),
                          );
                        }
                        return ListView.separated(
                          itemCount: state.attendanceOverview
                              .attendanceOverviewList!.length,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemBuilder: (context, index) {
                            return DashboardTableRow(
                              rowData: [
                                (index + 1).toString(),
                                state
                                    .attendanceOverview
                                    .attendanceOverviewList![index]
                                    .standardDivision,
                                state.attendanceOverview
                                    .attendanceOverviewList![index].totalPresent
                                    .toString(),
                                state
                                    .attendanceOverview
                                    .attendanceOverviewList![index]
                                    .totalStudents
                                    .toString(),
                                'View Absent',
                              ],
                              onAbsenteesView: () {
                                viewAbsenteesDialog(
                                  context: context,
                                  standard: state
                                      .attendanceOverview
                                      .attendanceOverviewList![index]
                                      .standardDivision
                                      .split(" ")[0],
                                  division: state
                                      .attendanceOverview
                                      .attendanceOverviewList![index]
                                      .standardDivision
                                      .split(" ")[1],
                                  branchId: widget.branchId,
                                  attendanceDetailedBloc:
                                      attendanceDetailedBloc,
                                );
                              },
                              isShimmer: false,
                            );
                          },
                        );
                      } else if (state is AttendanceOverviewError) {
                        return Center(
                          child: Text(state.errorMsg),
                        );
                      }
                      return ListView.separated(
                        itemCount: 5,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemBuilder: (context, index) {
                          return DashboardTableRow(
                            rowData: [
                              'Class ${index + 1}',
                              '10',
                              '20',
                              'View Absent',
                            ],
                            onAbsenteesView: null,
                            isShimmer: true,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Income vs Expense",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
