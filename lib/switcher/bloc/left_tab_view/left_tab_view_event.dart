abstract class LeftTabViewEvent {}

class LeftTabViewSwitch extends LeftTabViewEvent {
  final int index;

  LeftTabViewSwitch(this.index);
}
