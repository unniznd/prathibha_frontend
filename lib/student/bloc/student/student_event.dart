abstract class StudentEvent {}

class FetchStudentDetails extends StudentEvent {
  final int branchId;

  FetchStudentDetails(this.branchId);
}
