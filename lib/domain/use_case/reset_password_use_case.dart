import 'package:taskmanager/domain/repository/interface/i_auth_repository.dart';

class ResetPasswordUseCase {
  final IAuthRepository repository;

  ResetPasswordUseCase({required this.repository});

  Future<void> call(String email) {
    return repository.sendPasswordResetEmail(email);
  }
}