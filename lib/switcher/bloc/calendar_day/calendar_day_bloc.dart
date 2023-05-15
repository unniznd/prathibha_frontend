import 'package:flutter_bloc/flutter_bloc.dart';
import 'calendar_day_event.dart';
import 'calendar_day_state.dart';

class CalendarDayBloc extends Bloc<CalendarDayEvent, CalendarDayState> {
  CalendarDayBloc() : super(CalendarDayState(selectedDay: DateTime.now())) {
    on<SelectedDayEvent>((event, emit) {
      emit(CalendarDayState(selectedDay: event.selectedDay));
    });
  }
}
