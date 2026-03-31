import 'package:taskmanager/core/results/result.dart';
import 'package:taskmanager/features/auth/domain/entities/app_error.dart';
import 'package:taskmanager/features/auth/domain/repositories/interface/i_auth_repository.dart';

class LoginWithGoogleUseCase {
  final IAuthRepository _repository;

  LoginWithGoogleUseCase({required IAuthRepository repository}) : _repository = repository;

  Future<Result<Object?, AppError>> call() {
    return _repository.loginWithGoogle();
  }
}