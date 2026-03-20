import 'package:taskmanager/domain/entity/auth_credential.dart';
import 'package:taskmanager/domain/repository/interface/i_auth_repository.dart';

class LoginWithEmailUseCase {
  final IAuthRepository _repository;

  LoginWithEmailUseCase({required IAuthRepository repository})
    : _repository = repository;

  Future<AppAuthCredential> call(String email, String password) {
    return _repository.loginWithPassword(email, password);
  }
}