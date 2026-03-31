import 'package:taskmanager/core/results/result.dart';
import 'package:taskmanager/features/auth/domain/entities/app_error.dart';
import 'package:taskmanager/features/auth/domain/repositories/interface/i_auth_repository.dart';

class LoginWithEmailUseCase {
  final IAuthRepository _repository;

  LoginWithEmailUseCase({required IAuthRepository repository})
    : _repository = repository;

  Future<Result<Object, AppError>> call(String email, String password) {
    return _repository.loginWithPassword(email, password);
  }
}