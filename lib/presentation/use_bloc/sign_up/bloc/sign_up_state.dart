sealed class SignUpState {}

class SignUpInitState extends SignUpState {}

class SignUpLoadingState extends SignUpState {
  final bool loading;

  SignUpLoadingState(this.loading);
}

class SignUpErrorState extends SignUpState {
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;
  final int? code;
  final String? message;

  SignUpErrorState({
    this.emailError, 
    this.passwordError, 
    this.confirmPasswordError,
    this.code,
    this.message
  });
}

class SignUpSuccessState extends SignUpState {}