abstract class DivisionEvent {}

class ChangeDivision extends DivisionEvent {
  final String? divisionName;

  ChangeDivision({required this.divisionName});
}
