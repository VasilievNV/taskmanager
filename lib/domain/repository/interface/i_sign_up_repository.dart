import 'package:taskmanager/domain/entity/auth_credential.dart';

abstract interface class ISignUpRepository {
  Future<AppAuthCredential> signUpWithPassword(String email, String password, String confirmPassword);
}