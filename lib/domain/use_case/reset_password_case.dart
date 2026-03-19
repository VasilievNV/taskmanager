import 'package:taskmanager/domain/repository/Impl/reset_password_repository.dart';

class ResetPasswordUseCase {
  final ResetPasswordRepository repository;

  ResetPasswordUseCase({required this.repository});

  Future<void> call(String email) => repository.sendLink(email);
}