import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:prathibha_web/student/api/student_api.dart';

import 'add_student_event.dart';
import 'add_student_state.dart';

class AddStudentBloc extends Bloc<AddStudentEvent, AddStudentState> {
  final StudentApiProvider studentApiProvider = StudentApiProvider();
  AddStudentBloc() : super(AddStudentInitial()) {
    on<AddStudentEvent>((event, emit) async {
      emit(AddStudentAdding());
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
                'Adding Student.',
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
        final res = await studentApiProvider.addStudent(
          event.branchId,
          event.admissionNumber,
          event.name,
          event.standard,
          event.division,
          event.phoneNumber,
        );
        if (res) {
          // ignore: use_build_context_synchronously
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
                    'Added Student. Refresh the students page',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
          emit(AddStudentAdded());
        } else {
          // ignore: use_build_context_synchronously
          final scaffoldMessenger = ScaffoldMessenger.of(event.context);
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
                    'Failed to add student',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
          emit(AddStudentError("Error Occured"));
        }
      } catch (e) {
        emit(AddStudentError(e.toString()));
      }
    });
  }
}
