import 'package:taskmanager/features/auth/domain/entities/app_auth_credential.dart';

abstract interface class IAuthRepository {
  Future<AppAuthCredential> loginWithPassword(String email, String password);
  Future<AppAuthCredential> signUpWithPassword(String email, String password);
  Future<AppAuthCredential> loginWithGoogle();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> signOut();
}