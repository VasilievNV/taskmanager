import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/core/utils/console.dart';
import 'package:taskmanager/domain/use_case/login_case.dart';
import 'package:taskmanager/presentation/use_bloc/login/bloc/login_event.dart';
import 'package:taskmanager/presentation/use_bloc/login/bloc/login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginCase login;

  LoginBloc(this.login) : super(LoginState()) {
    on<LoginEditEmailEvent>((event, emit) {
      login.emailText = event.text;
    });

    on<LoginEditPasswordEvent>((event, emit) {
      login.passwordText = event.text;
    });

    on<LoginObscurePasswordEvent>((event, emit) {
      emit(state.copyWith(obscureText: event.value));
    });

    on<LoginWithPasswordEvent>((event, emit) async {
      final (emailError, passwordError, isError) = login.validateForms();

      if (isError) {
        emit(state.copyWith(
          status: LoginStatus.error,
          emailError: emailError,
          passwordError: passwordError
        ));
        return;
      }

      emit(LoginLoadingState(true));

      final credential = await login.repository.loginWithPassword(login.emailText, login.passwordText);

      emit(LoginLoadingState(false));

      if (credential.user != null) {
        emit(state.copyWith(status: LoginStatus.success));
      } else {

        Console.log("Login error");
        Console.log("code: ${credential.error?.code}");
        Console.log("message: ${credential.error?.code}");

        emit(state.copyWith(
          status: LoginStatus.error,
          emailError: credential.error?.message,
        ));
      }
    });
  }
}