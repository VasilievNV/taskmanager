import 'package:taskmanager/domain/entity/auth_credential.dart';

abstract interface class IAuthRepository {
  Future<AppAuthCredential> loginWithPassword(String email, String password);
  Future<AppAuthCredential> signUpWithPassword(String email, String password, String confirmPassword);
  Future<AppAuthCredential> loginWithGoogle();
  Future<AppAuthCredential> loginWithApple();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> signOut();
}