import 'package:taskmanager/core/utils/extensions.dart';
import 'package:taskmanager/domain/repository/interface/i_sign_up_repository.dart';

class SignUpCase {
  final ISignUpRepository repository;

  String emailText = "";
  String passwordText = "";
  String confirmPasswordText = "";

  SignUpCase({required this.repository});


  (String? emailError, String? passwordError, String? confirmError, bool isError) validateForms() {
    String? emailError;
    String? passwordError;
    String? confirmError;
    bool isError = false;

    // Проверка email
    if (emailText.isEmpty) {
      emailError = "Required";
    } else if (!emailText.isEmail) {
      emailError = "InvalidEmail";
    }

    // Проверка пароля
    if (passwordText.isEmpty) {
      passwordError = "Required";
    } 

    // Проверка подтверждения пароля
    if (confirmPasswordText.isEmpty) {
      confirmError = "Required";
    } else if (passwordText != confirmPasswordText) {
      confirmError = "Passwords don't match";
    }

    isError = emailError != null || passwordError != null || confirmError != null;

    return (emailError, passwordError, confirmError, isError);
  }
}