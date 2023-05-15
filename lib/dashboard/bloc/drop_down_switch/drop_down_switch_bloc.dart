import 'package:flutter_bloc/flutter_bloc.dart';

import 'drop_down_switch_event.dart';
import 'drop_down_switch_state.dart';

class DropDownSwitchBloc
    extends Bloc<DropDownSwitchEvent, DropDownSwitchState> {
  DropDownSwitchBloc() : super(DropDownSwitchInitialState()) {
    on<DropDownSwitchEventChange>((event, emit) {
      emit(DropDownSwitchedState(newBranch: event.newBranch));
    });
  }
}
