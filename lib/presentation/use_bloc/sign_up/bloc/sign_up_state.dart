import 'package:equatable/equatable.dart';

enum ESignUpStatus { initial, editing, loading, success, error }

class SignUpState extends Equatable {
  final String emailText;
  final String passwordText;
  final String confirmText;
  final bool isLoading;

  final bool obscureTextPassword;
  final bool obscureTextConfirm;
  final ESignUpStatus status;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;

  const SignUpState({
    this.emailText = "",
    this.passwordText = "",
    this.confirmText = "",
    this.isLoading = false,
    this.obscureTextPassword = true,
    this.obscureTextConfirm = true,
    this.status = ESignUpStatus.initial,
    this.emailError, 
    this.passwordError, 
    this.confirmPasswordError,
  });

  SignUpState copyWith({
    String? emailText,
    String? passwordText,
    String? confirmText,
    bool? isLoading,
    bool? obscureTextPassword,
    bool? obscureTextConfirm,
    ESignUpStatus? status,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    String? errorMessage
  }) {
    return SignUpState(
      emailText: emailText ?? this.emailText,
      passwordText: passwordText ?? this.passwordText,
      confirmText: confirmText ?? this.confirmText,
      isLoading: isLoading ?? this.isLoading,
      obscureTextPassword: obscureTextPassword ?? this.obscureTextPassword,
      obscureTextConfirm: obscureTextConfirm ?? this.obscureTextConfirm,
      status: status ?? this.status,
      emailError: emailError,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
    );
  }
  
  @override
  List<Object?> get props => [
    emailText,
    passwordText,
    confirmText,
    isLoading,
    obscureTextPassword, 
    obscureTextConfirm,
    status,
    emailError,
    passwordError,
    confirmPasswordError,
  ];
}