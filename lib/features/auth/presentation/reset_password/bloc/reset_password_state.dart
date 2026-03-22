import 'package:equatable/equatable.dart';


sealed class ResetPasswordState extends Equatable {
  final String emailText;
  final String? emailError;

  bool get isLoading => false;

  const ResetPasswordState({
    this.emailText = "", 
    this.emailError
  });

  @override
  List<Object?> get props => [emailText, emailError];
}

class ResetPasswordInitial extends ResetPasswordState {
  const ResetPasswordInitial({super.emailText, super.emailError});
}

class ResetPasswordEditing extends ResetPasswordState {
  const ResetPasswordEditing({super.emailText, super.emailError});
}

class ResetPasswordLoading extends ResetPasswordState {
  @override
  bool get isLoading => true;

  const ResetPasswordLoading({super.emailText, super.emailError});
}

class ResetPasswordSuccess extends ResetPasswordState {
  const ResetPasswordSuccess({super.emailText});
}

class ResetPasswordError extends ResetPasswordState {
  const ResetPasswordError({super.emailText, super.emailError});
}