abstract class ClassEvent {}

class ChangeClass extends ClassEvent {
  final String? className;

  ChangeClass({required this.className});
}
