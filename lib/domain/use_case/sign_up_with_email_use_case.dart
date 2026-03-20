import 'package:taskmanager/domain/entity/auth_credential.dart';
import 'package:taskmanager/domain/repository/interface/i_auth_repository.dart';

class SignUpWithEmailUseCase {
  final IAuthRepository _repository;

  SignUpWithEmailUseCase({required IAuthRepository repository})
    : _repository = repository;

  Future<AppAuthCredential> call(String email, String password, String confirmPassword) {
    return _repository.signUpWithPassword(email, password, confirmPassword);
  }
}