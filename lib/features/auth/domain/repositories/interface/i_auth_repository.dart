import 'package:taskmanager/core/results/result.dart';
import 'package:taskmanager/features/auth/domain/entities/app_error.dart';

abstract interface class IAuthRepository {
  Future<Result<Object, AppError>> loginWithPassword(String email, String password);
  Future<Result<Object, AppError>> signUpWithPassword(String email, String password);
  Future<Result<Object?, AppError>> loginWithGoogle();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> signOut();
}