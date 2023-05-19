abstract class UnpaidEvent {}

class UpdateUnpaid extends UnpaidEvent {
  final bool isActive;

  UpdateUnpaid({required this.isActive});
}
