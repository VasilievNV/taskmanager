import 'package:taskmanager/domain/entity/auth_credential.dart';
import 'package:taskmanager/domain/repository/interface/i_sign_up_repository.dart';

class SignUpUseCase {
  final ISignUpRepository repository;

  SignUpUseCase({required this.repository});

  Future<AppAuthCredential> callWithPassword(String email, String password, String confirmPassword) {
    return repository.signUpWithPassword(email, password, confirmPassword);
  }
}