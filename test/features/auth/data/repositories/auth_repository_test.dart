import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taskmanager/core/results/result.dart';
import 'package:taskmanager/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:taskmanager/features/auth/data/models/user_model.dart';
import 'package:taskmanager/features/auth/data/repositories/Impl/auth_repository.dart';
import 'package:taskmanager/features/auth/domain/entities/app_error.dart';


class MockAuthRemoteDataSource extends Mock implements IAuthRemoteDataSource {}

void main() {
  late AuthRepository repository;
  late MockAuthRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockAuthRemoteDataSource();
    repository = AuthRepository(dataSource: mockDataSource);
  });

  group('loginWithPassword', () {
    const tEmail = 'test@test.com';
    const tPassword = 'password123';
    final tUser = UserModel(uid: '1', email: tEmail);

    test('должен вернуть Success(user) при успешной авторизации', () async {
      when(() => mockDataSource.loginWithPassword(tEmail, tPassword))
          .thenAnswer((_) async => tUser);

      final result = await repository.loginWithPassword(tEmail, tPassword);

      expect(result, isA<Success<Object, AppError>>());
      expect((result as Success).value, tUser);
      verify(() => mockDataSource.loginWithPassword(tEmail, tPassword)).called(1);
    });

    test('должен вернуть Failure с кодом 1 при InvalidCredentialsException', () async {
      when(() => mockDataSource.loginWithPassword(tEmail, tPassword))
          .thenThrow(InvalidCredentialsException());

      final result = await repository.loginWithPassword(tEmail, tPassword);

      expect(result, isA<Failure<Object, AppError>>());
      final failure = result as Failure;
      expect(failure.error.message, "Incorrect email or password");
      expect(failure.error.code, 1);
    });

    test('должен вернуть дефолтный Failure при неизвестной ошибке (catch)', () async {
      when(() => mockDataSource.loginWithPassword(tEmail, tPassword))
          .thenThrow(Exception('Random crash'));

      final result = await repository.loginWithPassword(tEmail, tPassword);

      expect(result, isA<Failure<Object, AppError>>());
      expect((result as Failure).error.code, 0);
    });
  });
}