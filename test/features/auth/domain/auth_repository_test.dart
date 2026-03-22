import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taskmanager/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:taskmanager/features/auth/data/models/user_model.dart';
import 'package:taskmanager/features/auth/domain/repositories/Impl/auth_repository.dart';


class MockAuthRemoteDataSource extends Mock implements IAuthRemoteDataSource {}

void main() {
  late AuthRepository repository;
  late MockAuthRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockAuthRemoteDataSource();
    repository = AuthRepository(dataSource: mockDataSource);
  });

  const tEmail = 'test@test.com';
  const tPassword = 'password123';
  const tUserModel = UserModel(uid: '123', email: tEmail);

  group('loginWithPassword', () {
    test('should return AppAuthCredential with user when successful', () async {
      when(() => mockDataSource.loginWithPassword(tEmail, tPassword)).thenAnswer((_) async => tUserModel);

      final result = await repository.loginWithPassword(tEmail, tPassword);

      expect(result.user, tUserModel);
      expect(result.error, null);
      verify(() => mockDataSource.loginWithPassword(tEmail, tPassword)).called(1);
    });

    test('should return AppError with correct message when InvalidCredentialsException occurs', () async {

      when(() => mockDataSource.loginWithPassword(any(), any())).thenThrow(InvalidCredentialsException());

      final result = await repository.loginWithPassword(tEmail, tPassword);

      expect(result.user, null);
      expect(result.error?.message, "Incorrect email or password");
    });

    test('should return AppError with generic message when ServerException occurs', () async {

      when(() => mockDataSource.loginWithPassword(any(), any())).thenThrow(ServerException());

      final result = await repository.loginWithPassword(tEmail, tPassword);

      expect(result.error?.message, "Unexpected error. Please try later");
    });
  });

  group('signUpWithPassword', () {
    test('should return AppError when EmailAlreadyInUseException is thrown', () async {
      when(() => mockDataSource.signUpWithPassword(any(), any())).thenThrow(EmailAlreadyInUseException());

      final result = await repository.signUpWithPassword(tEmail, tPassword);

      expect(result.error?.message, "Email is exist");
    });
  });

  group('signOut', () {
    test('should call signOut on the dataSource', () async {
      when(() => mockDataSource.signOut()).thenAnswer((_) async => {});

      await repository.signOut();

      verify(() => mockDataSource.signOut()).called(1);
    });
  });
}