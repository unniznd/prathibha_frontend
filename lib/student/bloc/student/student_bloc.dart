import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prathibha_web/student/api/student_api.dart';

import 'student_event.dart';
import 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentApiProvider studentApiProvider = StudentApiProvider();
  StudentBloc() : super(StudentLoading()) {
    on<FetchStudentDetails>((event, emit) async {
      emit(StudentLoading());
      try {
        final studentModel = await studentApiProvider.fetchStudentDetails(
          event.branchId,
          event.standard,
          event.division,
        );
        if (studentModel.errorMsg != null) {
          emit(StudentError(studentModel.errorMsg!));
        } else {
          emit(StudentLoaded(studentModel));
        }
      } catch (e) {
        emit(StudentError("Error Occured: Try Again!"));
      }
    });
  }
}
