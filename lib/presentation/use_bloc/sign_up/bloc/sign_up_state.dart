/*sealed class SignUpState {}

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

class SignUpSuccessState extends SignUpState {}*/

import 'package:equatable/equatable.dart';

enum SignUpStatus { initial, success, error }

class SignUpState extends Equatable {
  final bool obscureTextPassword;
  final bool obscureTextConfirm;
  final SignUpStatus status;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;
  final String? errorMessage;

  const SignUpState({
    this.obscureTextPassword = true,
    this.obscureTextConfirm = true,
    this.status = SignUpStatus.initial,
    this.emailError, 
    this.passwordError, 
    this.confirmPasswordError,
    this.errorMessage
  });

  SignUpState copyWith({
    bool? obscureTextPassword,
    bool? obscureTextConfirm,
    SignUpStatus? status,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    String? errorMessage
  }) {
    return SignUpState(
      obscureTextPassword: obscureTextPassword ?? this.obscureTextPassword,
      obscureTextConfirm: obscureTextConfirm ?? this.obscureTextConfirm,
      status: status ?? this.status,
      emailError: emailError,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
      errorMessage: errorMessage
    );
  }
  
  @override
  List<Object?> get props => [
    obscureTextPassword, 
    obscureTextConfirm,
    status,
    emailError,
    passwordError,
    confirmPasswordError,
    errorMessage
  ];
}

class SignUpLoadingState extends SignUpState {
  final bool loading;

  const SignUpLoadingState(this.loading);

  @override
  List<Object?> get props => [loading];
}