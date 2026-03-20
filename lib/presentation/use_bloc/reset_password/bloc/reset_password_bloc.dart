import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/core/utils/extensions.dart';
import 'package:taskmanager/domain/use_case/reset_password_use_case.dart';
import 'package:taskmanager/presentation/use_bloc/reset_password/bloc/reset_password_event.dart';
import 'package:taskmanager/presentation/use_bloc/reset_password/bloc/reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ResetPasswordUseCase useCase;

  ResetPasswordBloc(this.useCase) : super(ResetPasswordInitial()) {
    on<ResetPasswordEditEvent>((event, emit) {
      emit(ResetPasswordEditing(
        emailText: event.text 
      ));
    });

    on<ResetPasswordSendEmailEvent>((event, emit) async {
      final (emailError, isError) = _validateForm(state.emailText);

      if (isError) {
        emit(ResetPasswordInitial(
          emailText: state.emailText,
          emailError: state.emailError
        ));
        return;
      }

      emit(ResetPasswordLoading(
        emailText: state.emailText
      ));

      await useCase.call(state.emailText);

      emit(ResetPasswordSuccess(
        emailText: state.emailText
      ));
    });
  }

  (String? emailError, bool isError) _validateForm(String emailText) {
    bool isError = false;
    String? errorText;

    if (emailText.isEmpty) {
      errorText = "Required";
    } else if (!emailText.isEmail) {
      errorText = "Invalid email";
    }

    isError = errorText != null;

    return (errorText, isError);
  }
}