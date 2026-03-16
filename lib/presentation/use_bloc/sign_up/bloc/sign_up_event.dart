abstract class SignUpEvent {}

class SignUpEditEmailEvent extends SignUpEvent {
  final String text;

  SignUpEditEmailEvent(this.text);
}

class SignUpEditPasswordEvent extends SignUpEvent {
  final String text;

  SignUpEditPasswordEvent(this.text);
}

class SignUpEditConfirmEvent extends SignUpEvent {
  final String text;

  SignUpEditConfirmEvent(this.text);
}

class SignUpWithPasswordEvent extends SignUpEvent {}