import 'package:flutter_bloc/flutter_bloc.dart';

import 'absent_event.dart';
import 'absent_state.dart';

class AbsentBloc extends Bloc<AbsentEvent, AbsentState> {
  AbsentBloc() : super(AbsentState(false)) {
    on<UpdateAbsent>((event, emit) {
      emit(AbsentState(event.isActive));
    });
  }
}
