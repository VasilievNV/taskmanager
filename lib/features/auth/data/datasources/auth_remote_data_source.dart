import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taskmanager/features/auth/data/models/user_model.dart';

class ServerException implements Exception {}
class InvalidCredentialsException implements Exception {}
class UserDisabledException implements Exception {}
class EmailAlreadyInUseException implements Exception {}

abstract interface class IAuthRemoteDataSource {
  Future<UserModel> loginWithPassword(String email, String password);
  Future<UserModel> signUpWithPassword(String email, String password);
  Future<UserModel?> loginWithGoogle();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> signOut();
}

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSource({required this.firebaseAuth, required this.googleSignIn});

  @override
  Future<UserModel> loginWithPassword(String email, String password) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return UserModel.fromFirebase(credential.user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-credential": throw InvalidCredentialsException();
        case "user-disabled": throw UserDisabledException();
        default: throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> signUpWithPassword(String email, String password) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return UserModel.fromFirebase(credential.user);
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "email-already-in-use": throw EmailAlreadyInUseException();
        default: throw ServerException();
      }
    } catch (error) {
      throw ServerException();
    }
  }

  @override
  Future<UserModel?> loginWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(idToken: googleAuth.idToken);
      final userCredential = await firebaseAuth.signInWithCredential(authCredential);

      return UserModel.fromFirebase(userCredential.user);
    } on FirebaseAuthException catch (_) {
      throw ServerException();
    } on GoogleSignInException catch (error) {
      if (error.code != GoogleSignInExceptionCode.canceled) {
        throw ServerException();
      }
      return null;
    } catch (error) {
      throw ServerException();
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    return firebaseAuth.sendPasswordResetEmail(email: email);
  }
  
  @override
  Future<void> signOut() {
    return firebaseAuth.signOut();
  }
}