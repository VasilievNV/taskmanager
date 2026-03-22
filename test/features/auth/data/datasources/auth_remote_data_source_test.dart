import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taskmanager/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taskmanager/features/auth/data/models/user_model.dart';

// Создаем моки
class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockGoogleSignIn extends Mock implements GoogleSignIn {}
class MockUserCredential extends Mock implements UserCredential {}
class MockUser extends Mock implements User {}

void main() {
  late AuthRemoteDataSource dataSource;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockGoogleSignIn mockGoogleSignIn;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();
    dataSource = AuthRemoteDataSource(
      firebaseAuth: mockFirebaseAuth,
      googleSignIn: mockGoogleSignIn,
    );
  });

  group('loginWithPassword', () {
    const tEmail = 'test@test.com';
    const tPassword = 'password123';

    test('should return UserModel when login is successful', () async {
      final mockUserCredential = MockUserCredential();
      final mockUser = MockUser();
      
      when(() => mockUser.uid).thenReturn('123');
      when(() => mockUser.emailVerified).thenReturn(false); 
      when(() => mockUser.email).thenReturn(tEmail);
      when(() => mockUserCredential.user).thenReturn(mockUser);
      
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
        email: tEmail, 
        password: tPassword,
      )).thenAnswer((_) async => mockUserCredential);

      final result = await dataSource.loginWithPassword(tEmail, tPassword);

      expect(result, isA<UserModel>());
      expect(result.uid, '123');
    });

    test('should throw InvalidCredentialsException on "invalid-credential" code', () async {
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      )).thenThrow(FirebaseAuthException(code: 'invalid-credential'));

      expect(
        () => dataSource.loginWithPassword(tEmail, tPassword),
        throwsA(isA<InvalidCredentialsException>()),
      );
    });

    test('should throw ServerException on unknown error', () async {
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      )).thenThrow(Exception());

      expect(
        () => dataSource.loginWithPassword(tEmail, tPassword),
        throwsA(isA<ServerException>()),
      );
    });
  });


  group('signUpWithPassword', () {
    test('should throw EmailAlreadyInUseException when email is taken', () async {
      when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      )).thenThrow(FirebaseAuthException(code: 'email-already-in-use'));

      expect(
        () => dataSource.signUpWithPassword('test@test.com', '123456'),
        throwsA(isA<EmailAlreadyInUseException>()),
      );
    });
  });
}