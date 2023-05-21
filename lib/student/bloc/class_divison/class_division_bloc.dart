import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prathibha_web/student/api/student_api.dart';

import 'class_division_event.dart';
import 'class_divison_state.dart';

class StudentClassDivisionBloc
    extends Bloc<ClassDivisionEvent, ClassDivisionState> {
  final StudentApiProvider studentApiProvider = StudentApiProvider();
  StudentClassDivisionBloc() : super(ClassDivisionLoading()) {
    on<ClassDivisionFetch>((event, emit) async {
      emit(ClassDivisionLoading());
      try {
        final classDivisionModel =
            await studentApiProvider.fetchClassDivision(event.branchId);
        if (classDivisionModel.errorMsg != null) {
          emit(ClassDivisionError(classDivisionModel.errorMsg!));
        } else {
          emit(ClassDivisionLoaded(classDivisionModel));
        }
      } catch (e) {
        emit(ClassDivisionError("Error Occured: Try Again!"));
      }
    });
  }
}
