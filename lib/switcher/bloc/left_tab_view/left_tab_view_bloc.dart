import 'package:flutter_bloc/flutter_bloc.dart';

import 'left_tab_view_event.dart';
import 'left_tab_view_state.dart';

class LeftTabViewBloc extends Bloc<LeftTabViewEvent, LeftTabViewState> {
  LeftTabViewBloc() : super(DashBoardState()) {
    on<LeftTabViewSwitch>((event, emit) {
      if (event.index == 0) {
        emit(DashBoardState());
      } else if (event.index == 1) {
        emit(AttendanceState());
      } else if (event.index == 2) {
        emit(FinanceState());
      } else {
        emit(DashBoardState());
      }
    });
  }
}
