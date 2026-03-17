import 'package:taskmanager/core/utils/extensions.dart';
import '/domain/repository/interface/i_login_repository.dart';

class LoginCase {
  final ILoginRepository repository;

  String emailText = "";
  String passwordText = "";

  LoginCase({required this.repository});

  (String? emailError, String? passwordError, bool isError) validateForms() {
    String? emailError;
    String? passwordError;
    bool isError = false;

    // Проверка email
    if (emailText.isEmpty) {
      emailError = "Required";
    } else if (!emailText.isEmail) {
      emailError = "Invalid email";
    }    

    // Проверка пароля
    if (passwordText.isEmpty) {
      passwordError = "Required";
    }

    isError = emailError != null || passwordError != null;

    return (emailError, passwordError, isError);
  }
}