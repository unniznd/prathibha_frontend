import 'package:prathibha_web/fee/model/fee_model.dart';

abstract class FeeState {}

class FeeLoading extends FeeState {}

class FeeLoaded extends FeeState {
  final FeeModel feeModel;
  FeeLoaded({required this.feeModel});
}

class FeeError extends FeeState {
  final String errorMsg;
  FeeError({required this.errorMsg});
}
