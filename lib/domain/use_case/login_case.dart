import 'package:taskmanager/domain/entity/auth_credential.dart';

import '/domain/repository/interface/i_login_repository.dart';

class LoginUseCase {
  final ILoginRepository repository;

  LoginUseCase({required this.repository});

  Future<AppAuthCredential> callWithPassword(String email, String password) {
    return repository.loginWithPassword(email, password);
  }
}