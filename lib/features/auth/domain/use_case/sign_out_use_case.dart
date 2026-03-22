import 'package:taskmanager/features/auth/domain/repositories/interface/i_auth_repository.dart';

class SignOutUseCase {
  final IAuthRepository _repository;

  SignOutUseCase({required IAuthRepository repository})
    : _repository = repository;

  Future<void> call() {
    return _repository.signOut();
  }
}