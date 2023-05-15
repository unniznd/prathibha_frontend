abstract class AddEventState {}

class AddEventInitial extends AddEventState {}

class AddEventDateChanged extends AddEventState {
  final DateTime date;

  AddEventDateChanged(this.date);
}
