import 'package:taskmanager/domain/entity/auth_credential.dart';
import 'package:taskmanager/domain/repository/interface/i_auth_repository.dart';

class LoginWithEmailUseCase {
  final IAuthRepository repository;

  LoginWithEmailUseCase({required this.repository});

  Future<AppAuthCredential> call(String email, String password) {
    return repository.loginWithPassword(email, password);
  }
}