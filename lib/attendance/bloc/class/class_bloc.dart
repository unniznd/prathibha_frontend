import 'package:flutter_bloc/flutter_bloc.dart';

import 'class_event.dart';
import 'class_state.dart';

class AttendanceClassBloc extends Bloc<ClassEvent, ClassState> {
  AttendanceClassBloc() : super(ClassState()) {
    on<ChangeClass>((event, emit) {
      emit(ClassState(className: event.className));
    });
  }
}
