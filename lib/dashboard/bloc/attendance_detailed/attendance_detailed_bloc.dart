import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';

import 'package:prathibha_web/dashboard/api/dashboard_api.dart';
import 'package:prathibha_web/dashboard/model/attendace_detailed_model.dart';
import 'attendance_detailed_event.dart';
import 'attendance_detailed_state.dart';

class AttendanceDetailedBloc
    extends Bloc<AttendanceDetailedEvent, AttendanceDetailedState> {
  final DashboardApiProvider dashboardApiProvider = DashboardApiProvider();
  AttendanceDetailedBloc() : super(AttendanceDetailedLoading()) {
    on<FetchAttendanceDetailed>((event, emit) async {
      emit(AttendanceDetailedLoading());

      try {
        final AttendanceDetailedModel attendanceDetailedModel =
            await dashboardApiProvider.detailedAttendance(
          event.branchId,
          event.standard,
          event.division,
        );
        if (attendanceDetailedModel.errorMsg != null) {
          emit(AttendanceDetailedError(message: "No students found"));
        } else {
          emit(
            AttendanceDetailedLoaded(
                attendanceDetailedModel: attendanceDetailedModel),
          );
        }
      } catch (e) {
        emit(AttendanceDetailedError(message: e.toString()));
      }
    });
    on<NotifyAbsentees>((event, emit) async {
      final scaffoldMessenger = ScaffoldMessenger.of(event.context);
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.blue,
          content: Row(
            children: [
              HeroIcon(
                HeroIcons.exclamationCircle,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Sending message to absentees...',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      );
      try {
        final bool success = await dashboardApiProvider.notifyAbsentees(
          event.branchId,
          event.standard,
          event.division,
        );
        if (success) {
          scaffoldMessenger.showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              content: Row(
                children: [
                  HeroIcon(
                    HeroIcons.exclamationCircle,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Message sent successfully',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          scaffoldMessenger.showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              content: Row(
                children: [
                  HeroIcon(
                    HeroIcons.exclamationCircle,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Error sending message',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      } catch (e) {
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Row(
              children: [
                HeroIcon(
                  HeroIcons.exclamationCircle,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Error sending message',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    });
  }
}
