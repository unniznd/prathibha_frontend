import 'package:flutter_bloc/flutter_bloc.dart';

import 'left_tab_view_event.dart';
import 'left_tab_view_state.dart';

class LeftTabViewBloc extends Bloc<LeftTabViewEvent, LeftTabViewState> {
  LeftTabViewBloc() : super(DashBoardState()) {
    on<LeftTabViewSwitch>((event, emit) {
      if (event.tabIndex == 0) {
        emit(DashBoardState());
      } else if (event.tabIndex == 1) {
        emit(StudentsState());
      } else if (event.tabIndex == 2) {
        emit(AttendanceState());
      } else if (event.tabIndex == 3) {
        emit(FeeState());
      } else if (event.tabIndex == 4) {
        emit(ReportsState());
      } else if (event.tabIndex == 5) {
        emit(SettingsState());
      } else {
        emit(DashBoardState());
      }
    });
  }
}
