import 'package:taskmanager/core/results/result.dart';
import 'package:taskmanager/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:taskmanager/features/auth/domain/entities/app_error.dart';
import 'package:taskmanager/features/auth/domain/repositories/interface/i_auth_repository.dart';


class AuthRepository implements IAuthRepository {
  final IAuthRemoteDataSource dataSource;

  const AuthRepository({required this.dataSource});

  @override
  Future<Result<Object, AppError>> loginWithPassword(String email, String password) async {
    try {
      final user = await dataSource.loginWithPassword(email, password);
      return Success(user);
    } on InvalidCredentialsException {
      return const Failure(AppError(code: 1, message: "Incorrect email or password"));
    } on UserDisabledException {
      return const Failure(AppError(code: 1, message: "User disabled"));
    } on ServerException {
      return const Failure(AppError(code: 1, message: "Unexpected error. Please try later"));
    } catch (e) {
      return Failure(AppError(code: 0, message: e.toString()));
    }
  }

  @override
  Future<Result<Object, AppError>> signUpWithPassword(String email, String password) async {
    try {
      final user = await dataSource.signUpWithPassword(email, password);
      return Success(user);
    } on EmailAlreadyInUseException catch(_) {
      return Failure(AppError(code: 1, message: "Email is exist"));
    } on ServerException catch(_) {
      return Failure(AppError(code: 1, message: "Unexpected error. Please try later"));
    } catch (error) {
      return Failure(AppError(code: 0, message: "Unexpected error. Please try later"));
    }
  }

  @override
  Future<Result<Object?, AppError>> loginWithGoogle() async {    
    try {
      final user = await dataSource.loginWithGoogle();
      return Success(user);
    } on ServerException catch (_) {
      return Failure(AppError(code: 1, message: "Unexpected error. Please try later"));
    } catch (error) {
      return Failure(AppError(code: 0, message: "Unexpected error. Please try later"));
    }
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