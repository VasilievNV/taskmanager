import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskmanager/core/utils/console.dart';
import 'package:taskmanager/domain/entity/app_user.dart';
import 'package:taskmanager/domain/entity/auth_credential.dart';
import 'package:taskmanager/domain/entity/error.dart';
import 'package:taskmanager/domain/repository/interface/i_login_repository.dart';

class LoginRepository implements ILoginRepository {
  final FirebaseAuth instance;

  LoginRepository({required this.instance});

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

      authError = AppError(message: error.message);
    } catch (error) {
      authError = AppError(message: "Unexpected error. Please try later");
    }
    
    return AppAuthCredential(error: authError);
  }

  @override
  Future<dynamic> loginWithGoogle() {
    throw UnimplementedError();
  }
  
  @override
  Future<dynamic> loginWithApple() {
    throw UnimplementedError();
  }
}