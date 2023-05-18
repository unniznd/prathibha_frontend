abstract class DropDownSwitchEvent {}

class DropDownSwitchEventChange extends DropDownSwitchEvent {
  final String newBranch;

  DropDownSwitchEventChange({required this.newBranch});
}
