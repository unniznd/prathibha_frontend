import 'package:flutter_bloc/flutter_bloc.dart';

import 'class_event.dart';
import 'class_state.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  ClassBloc() : super(ClassState()) {
    on<ChangeClass>((event, emit) {
      emit(ClassState(className: event.className));
    });
  }
}
