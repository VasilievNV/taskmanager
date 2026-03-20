import 'package:taskmanager/domain/entity/auth_credential.dart';
import 'package:taskmanager/domain/repository/interface/i_auth_repository.dart';

class SignUpWithEmailUseCase {
  final IAuthRepository repository;

  SignUpWithEmailUseCase({required this.repository});

  Future<AppAuthCredential> call(String email, String password, String confirmPassword) {
    return repository.signUpWithPassword(email, password, confirmPassword);
  }
}