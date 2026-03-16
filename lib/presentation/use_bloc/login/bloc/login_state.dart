sealed class LoginState {}

class LoginInitState extends LoginState {}

class LoginLoadingState extends LoginState {
  final bool loading;

  LoginLoadingState(this.loading);
}

class LoginErrorState extends LoginState {
  final String? emailError;
  final String? passwordError;
  final int? code;
  final String? message;

  LoginErrorState({
    this.emailError, 
    this.passwordError, 
    this.code,
    this.message
  });
}

class LoginSuccessState extends LoginState {}

