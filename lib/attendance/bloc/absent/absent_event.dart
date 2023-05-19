abstract class AbsentEvent {}

class UpdateAbsent extends AbsentEvent {
  final bool isActive;

  UpdateAbsent({required this.isActive});
}
