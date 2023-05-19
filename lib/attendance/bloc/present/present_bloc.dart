import 'package:flutter_bloc/flutter_bloc.dart';

import 'present_event.dart';
import 'present_state.dart';

class PresentBloc extends Bloc<PresentEvent, PresentState> {
  PresentBloc() : super(PresentState(false)) {
    on<UpdatePresent>((event, emit) {
      emit(PresentState(event.isActive));
    });
  }
}
