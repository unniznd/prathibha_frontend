abstract class AddEventEvent {}

class ChangeEventDate extends AddEventEvent {
  final DateTime date;

  ChangeEventDate(this.date);
}
