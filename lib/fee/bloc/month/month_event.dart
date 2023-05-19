abstract class MonthEvent {}

class ChangeMonth extends MonthEvent {
  final String? monthName;

  ChangeMonth({this.monthName});
}
