import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/core/results/result.dart';
import 'package:taskmanager/core/utils/extensions.dart';
import 'package:taskmanager/features/auth/domain/use_case/sign_up_with_email_use_case.dart';
import 'package:taskmanager/features/auth/presentation/sign_up/bloc/sign_up_event.dart';
import 'package:taskmanager/features/auth/presentation/sign_up/bloc/sign_up_state.dart';


class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpWithEmailUseCase signUpWithEmailUseCase;

  SignUpBloc({
    required this.signUpWithEmailUseCase
  }) : super(SignUpState()) {
    on<SignUpEditEmailEvent>((event, emit) {
      emit(state.copyWith(
        status: ESignUpStatus.editing,
        emailText: event.text
      ));
    });

    on<SignUpEditPasswordEvent>((event, emit) {
      emit(state.copyWith(
        status: ESignUpStatus.editing,
        passwordText: event.text
      ));
    });

    on<SignUpEditConfirmEvent>((event, emit) {
      emit(state.copyWith(
        status: ESignUpStatus.editing,
        confirmText: event.text
      ));
    });

    on<SignUpWithPasswordEvent>((event, emit) async {
      final (emailError, passwordError, confirmError, isError) = _validateForms();

      if (isError) {
        emit(state.copyWith(
          status: ESignUpStatus.error,
          emailError: emailError,
          passwordError: passwordError,
          confirmPasswordError: confirmError
        ));
        return;
      }

      emit(state.copyWith(
        status: ESignUpStatus.loading,
        isLoading: true
      ));

      final result = await signUpWithEmailUseCase.call(state.emailText, state.passwordText);

      emit(state.copyWith(
        status: ESignUpStatus.loading,
        isLoading: false
      ));

      switch (result) {
        case Success():
          emit(state.copyWith(status: ESignUpStatus.success));
          break;
        case Failure(:final error):
          emit(state.copyWith(
            status: ESignUpStatus.error,
            emailError: error.message
          ));
        }
    });
  }

  (String? emailError, String? passwordError, String? confirmError, bool isError) _validateForms() {
    String? emailError;
    String? passwordError;
    String? confirmError;
    bool isError = false;

    if (state.emailText.isEmpty) {
      emailError = "Required";
    } else if (!state.emailText.isEmail) {
      emailError = "InvalidEmail";
    }

    if (state.passwordText.isEmpty) {
      passwordError = "Required";
    } 

    if (state.confirmText.isEmpty) {
      confirmError = "Required";
    } else if (state.passwordText != state.confirmText) {
      confirmError = "Passwords don't match";
    }

    isError = emailError != null || passwordError != null || confirmError != null;

    return (emailError, passwordError, confirmError, isError);
  }
}