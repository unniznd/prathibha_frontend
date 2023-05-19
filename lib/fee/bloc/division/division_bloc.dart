import 'package:flutter_bloc/flutter_bloc.dart';

import 'division_event.dart';
import 'division_state.dart';

class DivisionBloc extends Bloc<DivisionEvent, DivisionState> {
  DivisionBloc() : super(DivisionState()) {
    on<ChangeDivision>((event, emit) {
      emit(DivisionState(divisionName: event.divisionName));
    });
  }
}
