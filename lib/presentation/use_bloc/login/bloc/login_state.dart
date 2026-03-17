import 'package:equatable/equatable.dart';

enum LoginStatus { initial, error, success }


class LoginState extends Equatable {
  final bool obscureText;
  final LoginStatus status;
  final String? emailError;
  final String? passwordError;
  final String? errorMessage;

  const LoginState({
    this.obscureText = true,
    this.status = LoginStatus.initial,
    this.emailError,
    this.passwordError,
    this.errorMessage,
  });

  LoginState copyWith({
    bool? obscureText,
    LoginStatus? status,
    String? emailError,
    String? passwordError,
    String? errorMessage,
  }) {
    return LoginState(
      obscureText: obscureText ?? this.obscureText,
      status: status ?? this.status,
      emailError: emailError,
      passwordError: passwordError,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [obscureText, emailError, passwordError, errorMessage];
}

class LoginLoadingState extends LoginState {
  final bool loading;

  const LoginLoadingState(this.loading);

  @override
  List<Object?> get props => [loading, ...super.props];
}

