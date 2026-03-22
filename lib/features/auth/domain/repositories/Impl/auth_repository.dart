import 'package:taskmanager/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:taskmanager/features/auth/domain/entities/app_auth_credential.dart';
import 'package:taskmanager/features/auth/domain/entities/app_error.dart';
import 'package:taskmanager/features/auth/domain/repositories/interface/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  final IAuthRemoteDataSource dataSource;

  const AuthRepository({required this.dataSource});

  @override
  Future<AppAuthCredential> loginWithPassword(String email, String password) async {
    final AppError authError;

    try {
      final user = await dataSource.loginWithPassword(email, password);
      return AppAuthCredential(user: user);
    } on InvalidCredentialsException catch(_) {
      authError = AppError(
        code: 1,
        message: "Incorrect email or password"
      );
    } on UserDisabledException catch(_) {
      authError = AppError(
        code: 1,
        message: "User disabled"
      );
    } on ServerException catch(_) {
      authError = AppError(
        code: 1,
        message: "Unexpected error. Please try later"
      );
    }
        
    return AppAuthCredential(error: authError);
  }

  @override
  Future<AppAuthCredential> signUpWithPassword(String email, String password) async {
    final AppError authError;

    try {
      final user = await dataSource.signUpWithPassword(email, password);
      return AppAuthCredential(user: user);
    } on EmailAlreadyInUseException catch(_) {
      authError = AppError(
        code: 1,
        message: "Email is exist"
      );
    } on ServerException catch(_) {
      authError = AppError(
        code: 1,
        message: "Unexpected error. Please try later"
      );
    }
    
    return AppAuthCredential(error: authError);
  }

  @override
  Future<AppAuthCredential> loginWithGoogle() async {
    final AppError authError;
    
    try {
      final user = await dataSource.loginWithGoogle();
      return AppAuthCredential(user: user);
    } on ServerException catch (_) {
      authError = AppError(
        code: 1,
        message: "Unexpected error. Please try later"
      );
    }

    return AppAuthCredential(error: authError);
  }
  
  @override
  Future<void> sendPasswordResetEmail(String email) {
    return dataSource.sendPasswordResetEmail(email);
  } 

  @override
  Future signOut() {
    return dataSource.signOut();
  }
}