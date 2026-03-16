import 'package:taskmanager/domain/entity/auth_credential.dart';

abstract interface class ILoginRepository {
  Future<AppAuthCredential> loginWithPassword(String email, String password);
  Future<dynamic> loginWithGoogle();
  Future<dynamic> loginWithApple();
}