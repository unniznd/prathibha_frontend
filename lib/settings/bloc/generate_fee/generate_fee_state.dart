abstract class GenerateFeeState {}

class GenerateFeeInitial extends GenerateFeeState {}

class GenerateFeeLoading extends GenerateFeeState {}

class GenerateFeeSuccess extends GenerateFeeState {}

class GenerateFeeFailure extends GenerateFeeState {
  final String message;

  GenerateFeeFailure({required this.message});
}
