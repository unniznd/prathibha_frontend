abstract class DateState {}

class DateInitial extends DateState {}

class DateChanged extends DateState {
  final DateTime date;

  DateChanged(this.date);
}
