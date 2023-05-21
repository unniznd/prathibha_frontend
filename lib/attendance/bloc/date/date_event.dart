abstract class DateEvent {}

class ChangeDate extends DateEvent {
  final DateTime date;

  ChangeDate(this.date);
}
