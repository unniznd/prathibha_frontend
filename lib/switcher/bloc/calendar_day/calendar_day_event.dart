abstract class CalendarDayEvent {}

class SelectedDayEvent extends CalendarDayEvent {
  final dynamic selectedDay, focusedDay;
  SelectedDayEvent(this.selectedDay, this.focusedDay);
}
