import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskmanager/domain/repository/interface/i_reset_password_repository.dart';

class ResetPasswordRepository implements IResetPasswordRepository {
  final FirebaseAuth instance;

  ResetPasswordRepository({required this.instance});

  @override
  Future<void> sendLink(String email) => instance.sendPasswordResetEmail(email: email);
}