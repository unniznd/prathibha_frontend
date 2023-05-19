abstract class PaidEvent {}

class UpdatePaid extends PaidEvent {
  final bool isActive;

  UpdatePaid({required this.isActive});
}
