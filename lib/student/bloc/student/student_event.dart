abstract class StudentEvent {}

class FetchStudentDetails extends StudentEvent {
  final int branchId;
  final String standard, division;

  FetchStudentDetails(this.branchId, this.standard, this.division);
}
