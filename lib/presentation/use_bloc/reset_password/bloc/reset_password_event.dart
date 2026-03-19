sealed class ResetPasswordEvent {}

class ResetPasswordEditEvent extends ResetPasswordEvent {
  final String text;

  ResetPasswordEditEvent(this.text);
}

class ResetPasswordSendEmailEvent extends ResetPasswordEvent {}