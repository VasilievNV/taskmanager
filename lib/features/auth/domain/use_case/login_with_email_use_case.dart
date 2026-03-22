import 'package:taskmanager/features/auth/domain/entities/app_auth_credential.dart';
import 'package:taskmanager/features/auth/domain/repositories/interface/i_auth_repository.dart';

class LoginWithEmailUseCase {
  final IAuthRepository _repository;

  LoginWithEmailUseCase({required IAuthRepository repository})
    : _repository = repository;

  Future<AppAuthCredential> call(String email, String password) {
    return _repository.loginWithPassword(email, password);
  }
}