abstract class FeeEvent {}

class FetchFee extends FeeEvent {
  final int branchId;
  FetchFee({required this.branchId});
}
