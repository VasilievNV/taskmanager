import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskmanager/core/utils/console.dart';
import 'package:taskmanager/domain/entity/app_user.dart';
import 'package:taskmanager/domain/entity/auth_credential.dart';
import 'package:taskmanager/domain/entity/error.dart';
import 'package:taskmanager/domain/repository/interface/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  final FirebaseAuth instance;

  const AuthRepository({required this.instance});

  @override
  Future<AppAuthCredential> loginWithPassword(String email, String password) async {
    final AppError authError;
    
    try {
      final firebaseCredential = await instance.signInWithEmailAndPassword(email: email, password: password);
      final user = AppUser(
        uid: firebaseCredential.user?.uid,
        email: firebaseCredential.user?.email
      );
      return AppAuthCredential(user: user);

    } on FirebaseAuthException catch (error) {
      Console.log(error.code);

      switch (error.code) {
        case "invalid-credential":
          authError = AppError(
            code: 1,
            message: "Incorrect email or password"
          );
          break;
        case "user-disabled":
          authError = AppError(
            code: 1,
            message: "User disabled"
          );
          break;
        default:
          authError = AppError(
            code: 1,
            message: "Unexpected error. Please try later"
          );
          break;
      }
  
    } catch (error) {
      authError = AppError(
        code: 1,
        message: "Unexpected error. Please try later"
      );
    }
    
    return AppAuthCredential(error: authError);
  }

  @override
  Future<AppAuthCredential> signUpWithPassword(String email, String password, String confirmPassword) async {
    final AppError authError;
    
    try {
      final firebaseCredential = await instance.createUserWithEmailAndPassword(email: email, password: password);
      final user = AppUser(
        uid: firebaseCredential.user?.uid,
        email: firebaseCredential.user?.email
      );
      return AppAuthCredential(user: user);

    } on FirebaseAuthException catch (error) {
      Console.log(error.code);

      switch (error.code) {
        case "email-already-in-use":
          authError = AppError(
            code: 1,
            message: "Email is exist"
          );
          break;
        case "*weak-password":
          authError = AppError(
            code: 1,
            message: "Password is too weak"
          );
          break;
        default:
          authError = AppError(
            code: 1,
            message: "Unexpected error. Please try later"
          );
          break;
      }
    } catch (error) {
      authError = AppError(
        code: 1,
        message: "Unexpected error. Please try later"
      );
    }
    
    return AppAuthCredential(error: authError);
  }

  @override
  Future<AppAuthCredential> loginWithGoogle() {
    throw UnimplementedError();
  }
  
  @override
  Future<AppAuthCredential> loginWithApple() {
    throw UnimplementedError();
  }
  
  @override
  Future<void> sendPasswordResetEmail(String email) {
    return instance.sendPasswordResetEmail(email: email);
  } 

  @override
  Future signOut() {
    return instance.signOut();
  }
}