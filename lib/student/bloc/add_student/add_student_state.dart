abstract class AddStudentState {}

class AddStudentInitial extends AddStudentState {}

class AddStudentAdding extends AddStudentState {}

class AddStudentAdded extends AddStudentState {}

class AddStudentError extends AddStudentState {
  final String message;

  AddStudentError(this.message);
}
