import 'package:taskmanager/domain/repository/interface/i_auth_repository.dart';

class ResetPasswordUseCase {
  final IAuthRepository _repository;

  ResetPasswordUseCase({required IAuthRepository repository})
    : _repository = repository;

  Future<void> call(String email) {
    return _repository.sendPasswordResetEmail(email);
  }
}