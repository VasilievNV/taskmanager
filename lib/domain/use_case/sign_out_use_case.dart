import 'package:taskmanager/domain/repository/interface/i_auth_repository.dart';

class SignOutUseCase {
  final IAuthRepository repository;

  SignOutUseCase({required this.repository});

  Future<void> call() {
    return repository.signOut();
  }
}