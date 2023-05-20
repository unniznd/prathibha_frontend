import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prathibha_web/common/config.dart';
import 'package:prathibha_web/login/api/login_api.dart';
import 'package:prathibha_web/login/model/login_model.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginApiProvider loginApiProvider = LoginApiProvider();
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final LoginModel loginModel = await loginApiProvider.authenticate(
          event.username,
          event.password,
        );
        if (loginModel.errorMsg != null) {
          emit(LoginFailure(error: loginModel.errorMsg!));
        } else {
          emit(LoginSuccess(loginModel: loginModel));
        }
      } catch (e) {
        emit(LoginFailure(error: "Error Occured: Try Again!"));
      }
    });
    on<LoginTokenCheck>((event, emit) async {
      emit(LoginTokenChecking());
      try {
        final token = getToken();

        final LoginModel loginModel = await loginApiProvider.dashboard(token);

        emit(LoginSuccess(loginModel: loginModel));
      } catch (e) {
        emit(LoginInitial());
      }
    });

    on<LoginLogout>((event, emit) async {
      emit(LoginInitial());
      deleteToken();
    });
  }
}

final loginBloc = LoginBloc();
