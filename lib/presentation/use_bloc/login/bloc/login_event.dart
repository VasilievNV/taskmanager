
abstract class LoginEvent {}

class LoginEditEmailEvent extends LoginEvent {
  final String text;

  LoginEditEmailEvent(this.text);
}

class LoginEditPasswordEvent extends LoginEvent {
  final String text;

  LoginEditPasswordEvent(this.text);
}

class LoginWithPasswordEvent extends LoginEvent {}