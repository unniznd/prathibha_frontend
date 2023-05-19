import 'package:flutter_bloc/flutter_bloc.dart';

import 'month_event.dart';
import 'month_state.dart';

class MonthBloc extends Bloc<MonthEvent, MonthState> {
  MonthBloc() : super(MonthState()) {
    on<ChangeMonth>((event, emit) {
      emit(MonthState(monthName: event.monthName));
    });
  }
}
