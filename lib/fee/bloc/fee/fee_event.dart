abstract class FeeEvent {}

class FetchFee extends FeeEvent {
  final int branchId;
  String standard, division, month, status;
  FetchFee({
    required this.branchId,
    required this.standard,
    required this.division,
    required this.month,
    required this.status,
  });
}
