import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taskmanager/features/auth/data/models/user_model.dart';
import 'package:taskmanager/features/auth/domain/entities/app_auth_credential.dart';
import 'package:taskmanager/features/auth/domain/entities/app_error.dart';
import 'package:taskmanager/features/auth/domain/use_case/login_with_email_use_case.dart';
import 'package:taskmanager/features/auth/domain/use_case/login_with_google_use_case.dart';
import 'package:taskmanager/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:taskmanager/features/auth/presentation/login/bloc/login_event.dart';
import 'package:taskmanager/features/auth/presentation/login/bloc/login_state.dart';

// Мокаем UseCases
class MockLoginWithEmailUseCase extends Mock implements LoginWithEmailUseCase {}
class MockLoginWithGoogleUseCase extends Mock implements LoginWithGoogleUseCase {}

void main() {
  late LoginBloc loginBloc;
  late MockLoginWithEmailUseCase mockEmailUseCase;
  late MockLoginWithGoogleUseCase mockGoogleUseCase;

  setUp(() {
    mockEmailUseCase = MockLoginWithEmailUseCase();
    mockGoogleUseCase = MockLoginWithGoogleUseCase();
    loginBloc = LoginBloc(
      loginWithEmailUseCase: mockEmailUseCase,
      loginWithGoogleUseCase: mockGoogleUseCase,
    );
  });

  // Закрываем блок после каждого теста
  tearDown(() => loginBloc.close());

  group('LoginBloc', () {
    // 1. Тест на изменение текста (простой синхронный ивент)
    blocTest<LoginBloc, LoginState>(
      'emits state with updated email when LoginEditEmailEvent is added',
      build: () => loginBloc,
      act: (bloc) => bloc.add(LoginEditEmailEvent('test@mail.com')),
      expect: () => [
        isA<LoginState>()
            .having((s) => s.emailText, 'emailText', 'test@mail.com')
            .having((s) => s.status, 'status', LoginStatus.editing),
      ],
    );

    // 2. Тест валидации (когда поля пустые)
    blocTest<LoginBloc, LoginState>(
      'emits error status when validation fails (empty fields)',
      build: () => loginBloc,
      act: (bloc) => bloc.add(LoginWithPasswordEvent()),
      expect: () => [
        isA<LoginState>()
            .having((s) => s.status, 'status', LoginStatus.error)
            .having((s) => s.emailError, 'emailError', 'Required')
            .having((s) => s.passwordError, 'passwordError', 'Required'),
      ],
    );

    // 3. Тест успешного входа (асинхронный)
    blocTest<LoginBloc, LoginState>(
      'emits [loading, loaded, success] when login is successful',
      build: () {
        // Настраиваем стейт блока перед вызовом (заполняем почту и пароль)
        loginBloc.add(LoginEditEmailEvent('valid@mail.com'));
        loginBloc.add(LoginEditPasswordEvent('123456'));
        
        when(() => mockEmailUseCase.call('valid@mail.com', '123456'))
            .thenAnswer((_) async => AppAuthCredential(user: UserModel(uid: '123')));
        return loginBloc;
      },
      skip: 2, // Пропускаем первые два стейта от LoginEdit...Event
      act: (bloc) => bloc.add(LoginWithPasswordEvent()),
      expect: () => [
        // Сначала включается лоадер
        isA<LoginState>().having((s) => s.isLoading, 'isLoading', true),
        // Потом выключается лоадер
        isA<LoginState>().having((s) => s.isLoading, 'isLoading', false),
        // В конце успех
        isA<LoginState>().having((s) => s.status, 'status', LoginStatus.success),
      ],
    );

    // 4. Тест ошибки от UseCase
    blocTest<LoginBloc, LoginState>(
      'emits error status when usecase returns error',
      build: () {
        loginBloc.add(LoginEditEmailEvent('valid@mail.com'));
        loginBloc.add(LoginEditPasswordEvent('123456'));
        
        when(() => mockEmailUseCase.call(any(), any()))
            .thenAnswer((_) async => AppAuthCredential(
                  error: AppError(message: 'Wrong password'),
                ));
        return loginBloc;
      },
      skip: 2,
      act: (bloc) => bloc.add(LoginWithPasswordEvent()),
      expect: () => [
        isA<LoginState>().having((s) => s.isLoading, 'isLoading', true),
        isA<LoginState>().having((s) => s.isLoading, 'isLoading', false),
        isA<LoginState>()
            .having((s) => s.status, 'status', LoginStatus.error)
            .having((s) => s.emailError, 'emailError', 'Wrong password'),
      ],
    );
  });
}