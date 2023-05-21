import 'package:prathibha_web/student/model/class_division_model.dart';

abstract class ClassDivisionState {}

class ClassDivisionLoading extends ClassDivisionState {}

class ClassDivisionLoaded extends ClassDivisionState {
  final StudentClassDivisionModel classDivisionModel;

  ClassDivisionLoaded(this.classDivisionModel);
}

class ClassDivisionError extends ClassDivisionState {
  final String error;

  ClassDivisionError(this.error);
}
