abstract class DropDownSwitchState {}

class DropDownSwitchInitialState extends DropDownSwitchState {}

class DropDownSwitchedState extends DropDownSwitchState {
  final String newBranch;

  DropDownSwitchedState({required this.newBranch});
}
