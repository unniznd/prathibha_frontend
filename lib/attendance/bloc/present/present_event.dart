abstract class PresentEvent {}

class UpdatePresent extends PresentEvent {
  final bool isActive;

  UpdatePresent({required this.isActive});
}
