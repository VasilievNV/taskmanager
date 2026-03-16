import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskmanager/core/utils/console.dart';
import 'package:taskmanager/domain/entity/app_user.dart';
import 'package:taskmanager/domain/entity/auth_credential.dart';
import 'package:taskmanager/domain/entity/error.dart';
import 'package:taskmanager/domain/repository/interface/i_sign_up_repository.dart';

class SignUpRepository implements ISignUpRepository {
  final FirebaseAuth instance;

  SignUpRepository({required this.instance});

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

      authError = AppError(message: error.message);
    } catch (error) {
      authError = AppError(message: "Unexpected error. Please try later");
    }
    
    return AppAuthCredential(error: authError);
  }
}