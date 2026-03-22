abstract class SignUpEvent {}

class SignUpEditEmailEvent extends SignUpEvent {
  final String text;

  SignUpEditEmailEvent(this.text);
}

class SignUpEditPasswordEvent extends SignUpEvent {
  final String text;

  SignUpEditPasswordEvent(this.text);
}

class SignUpObscurePasswordEvent extends SignUpEvent {
  final bool value;

  SignUpObscurePasswordEvent(this.value);
}

class SignUpObscureConfirmEvent extends SignUpEvent {
  final bool value;

  SignUpObscureConfirmEvent(this.value);
}

class SignUpEditConfirmEvent extends SignUpEvent {
  final String text;

  SignUpEditConfirmEvent(this.text);
}

class SignUpWithPasswordEvent extends SignUpEvent {}