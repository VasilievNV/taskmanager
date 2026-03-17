import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/domain/use_case/sign_up_case.dart';
import 'package:taskmanager/presentation/use_bloc/sign_up/bloc/sign_up_event.dart';
import 'package:taskmanager/presentation/use_bloc/sign_up/bloc/sign_up_state.dart';


class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpCase signUp;

  SignUpBloc(this.signUp) : super(SignUpState()) {
    on<SignUpEditEmailEvent>((event, emit) {
      signUp.emailText = event.text;
    });

    on<SignUpEditPasswordEvent>((event, emit) {
      signUp.passwordText = event.text;
    });

    on<SignUpEditConfirmEvent>((event, emit) {
      signUp.confirmPasswordText = event.text;
    });

    on<SignUpWithPasswordEvent>((event, emit) async {
      final (emailError, passwordError, confirmError, isError) = signUp.validateForms();

      if (isError) {
        emit(state.copyWith(
          status: SignUpStatus.error,
          emailError: emailError,
          passwordError: passwordError,
          confirmPasswordError: confirmError
        ));
        return;
      }

      emit(SignUpLoadingState(true));

      final credential = await signUp.repository.signUpWithPassword(
        signUp.emailText,
        signUp.passwordText,
        signUp.confirmPasswordText
      );

      emit(SignUpLoadingState(false));

      if (credential.user != null) {
        emit(state.copyWith(status: SignUpStatus.success));
      } else {
        emit(state.copyWith(
          emailError: credential.error?.message
        ));
      }
    });
  }
}