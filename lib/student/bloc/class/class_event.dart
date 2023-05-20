abstract class ClassEvent {}

class ChangeClass extends ClassEvent {
  final String? className;

  ChangeClass({this.className});
}
