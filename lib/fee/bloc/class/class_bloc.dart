import 'package:flutter_bloc/flutter_bloc.dart';

import 'class_event.dart';
import 'class_state.dart';

class FeeClassBloc extends Bloc<ClassEvent, ClassState> {
  FeeClassBloc() : super(ClassState()) {
    on<ChangeClass>((event, emit) {
      emit(ClassState(className: event.className));
    });
  }
}
