import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/core/utils/extensions.dart';
import 'package:taskmanager/domain/use_case/login_case.dart';
import 'package:taskmanager/presentation/use_bloc/login/bloc/login_event.dart';
import 'package:taskmanager/presentation/use_bloc/login/bloc/login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase useCase;

  LoginBloc(this.useCase) : super(LoginState()) {
    on<LoginEditEmailEvent>((event, emit) {
      emit(state.copyWith(
        status: LoginStatus.editing,
        emailText: event.text
      ));
    });

    on<LoginEditPasswordEvent>((event, emit) {
      emit(state.copyWith(
        status: LoginStatus.editing,
        passwordText: event.text
      ));
    });

    on<LoginObscurePasswordEvent>((event, emit) {
      emit(state.copyWith(
        status: LoginStatus.initial,
        obscureText: event.value
      ));
    });

    on<LoginWithPasswordEvent>((event, emit) async {
      final (emailError, passwordError, isError) = _validateForms();

      if (isError) {
        emit(state.copyWith(
          status: LoginStatus.error,
          emailError: emailError,
          passwordError: passwordError
        ));
        return;
      }

      emit(state.copyWith(
        status: LoginStatus.loading,
        isLoading: true
      ));

      final credential = await useCase.callWithPassword(state.emailText, state.passwordText);

      emit(state.copyWith(
        status: LoginStatus.loading,
        isLoading: false
      ));

      if (credential.user != null) {
        emit(state.copyWith(status: LoginStatus.success));
      } else {
        emit(state.copyWith(
          status: LoginStatus.error,
          emailError: credential.error?.message,
        ));
      }
    });
  }

  (String? emailError, String? passwordError, bool isError) _validateForms() {
    String? emailError;
    String? passwordError;
    bool isError = false;

    if (state.emailText.isEmpty) {
      emailError = "Required";
    } else if (!state.emailText.isEmail) {
      emailError = "Invalid email";
    }    

    if (state.passwordText.isEmpty) {
      passwordError = "Required";
    }

    isError = emailError != null || passwordError != null;

    return (emailError, passwordError, isError);
  }
}