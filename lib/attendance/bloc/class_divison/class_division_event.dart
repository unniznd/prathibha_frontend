abstract class ClassDivisionEvent {}

class ClassDivisionFetch extends ClassDivisionEvent {
  final int branchId;

  ClassDivisionFetch(this.branchId);
}
