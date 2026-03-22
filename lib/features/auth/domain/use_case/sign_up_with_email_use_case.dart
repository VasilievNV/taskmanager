import 'package:taskmanager/features/auth/domain/entities/app_auth_credential.dart';
import 'package:taskmanager/features/auth/domain/repositories/interface/i_auth_repository.dart';

class SignUpWithEmailUseCase {
  final IAuthRepository _repository;

  SignUpWithEmailUseCase({required IAuthRepository repository})
    : _repository = repository;

  Future<AppAuthCredential> call(String email, String password) {
    return _repository.signUpWithPassword(email, password);
  }
}