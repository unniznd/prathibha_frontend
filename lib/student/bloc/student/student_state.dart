import 'package:prathibha_web/student/model/student_model.dart';

abstract class StudentState {}

class StudentLoading extends StudentState {}

class StudentLoaded extends StudentState {
  final StudentModel studentModel;

  StudentLoaded(this.studentModel);
}

class StudentError extends StudentState {
  final String error;

  StudentError(this.error);
}
