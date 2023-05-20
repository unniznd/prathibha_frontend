import 'package:prathibha_web/login/model/login_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginModel loginModel;

  LoginSuccess({required this.loginModel});
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});
}

class LoginTokenChecking extends LoginState {}
