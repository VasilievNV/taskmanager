import 'package:equatable/equatable.dart';

enum LoginStatus { initial, editing, loading, error, success }


class LoginState extends Equatable {
  final String emailText;
  final String passwordText;
  final bool isLoading;
  final bool obscureText;
  final LoginStatus status;
  final String? emailError;
  final String? passwordError;
  final String? errorMessage;

  const LoginState({
    this.emailText = "",
    this.passwordText = "",
    this.isLoading = false,
    this.obscureText = true,
    this.status = LoginStatus.initial,
    this.emailError,
    this.passwordError,
    this.errorMessage,
  });

  LoginState copyWith({
    String? emailText,
    String? passwordText,
    bool? isLoading,
    bool? obscureText,
    LoginStatus? status,
    String? emailError,
    String? passwordError,
    String? errorMessage,
  }) {
    return LoginState(
      emailText: emailText ?? this.emailText,
      passwordText: passwordText ?? this.passwordText,
      isLoading: isLoading ?? this.isLoading,
      obscureText: obscureText ?? this.obscureText,
      status: status ?? this.status,
      emailError: emailError,
      passwordError: passwordError,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    emailText,
    passwordText,
    obscureText,
    status,
    isLoading,
    emailError, 
    passwordError, 
    errorMessage
  ];
}

