import 'package:taskmanager/features/auth/domain/entities/app_auth_credential.dart';
import 'package:taskmanager/features/auth/domain/repositories/interface/i_auth_repository.dart';

class LoginWithGoogleUseCase {
  final IAuthRepository _repository;

  LoginWithGoogleUseCase({required IAuthRepository repository}) : _repository = repository;

  Future<AppAuthCredential> call() {
    return _repository.loginWithGoogle();
  }
}