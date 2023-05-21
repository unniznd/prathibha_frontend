abstract class LeftTabViewEvent {}

class LeftTabViewSwitch extends LeftTabViewEvent {
  final int tabIndex;

  LeftTabViewSwitch(this.tabIndex);
}
