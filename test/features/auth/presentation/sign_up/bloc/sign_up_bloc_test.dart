import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taskmanager/features/auth/data/models/user_model.dart';
import 'package:taskmanager/features/auth/domain/entities/app_auth_credential.dart';
import 'package:taskmanager/features/auth/domain/entities/app_error.dart';
import 'package:taskmanager/features/auth/domain/use_case/sign_up_with_email_use_case.dart';
import 'package:taskmanager/features/auth/presentation/sign_up/bloc/sign_up_bloc.dart';
import 'package:taskmanager/features/auth/presentation/sign_up/bloc/sign_up_event.dart';
import 'package:taskmanager/features/auth/presentation/sign_up/bloc/sign_up_state.dart';

class MockSignUpWithEmailUseCase extends Mock implements SignUpWithEmailUseCase {}

void main() {
  late SignUpBloc signUpBloc;
  late MockSignUpWithEmailUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockSignUpWithEmailUseCase();
    signUpBloc = SignUpBloc(signUpWithEmailUseCase: mockUseCase);
  });

  tearDown(() => signUpBloc.close());

  group('SignUpBloc', () {
    const tEmail = 'newuser@mail.com';
    const tPassword = 'password123';

    // 1. Тест на ошибку подтверждения пароля
    blocTest<SignUpBloc, SignUpState>(
      'emits error when passwords do not match',
      build: () => signUpBloc,
      seed: () => SignUpState(
        emailText: tEmail,
        passwordText: tPassword,
        confirmText: 'wrong_password',
      ),
      act: (bloc) => bloc.add(SignUpWithPasswordEvent()),
      expect: () => [
        isA<SignUpState>()
            .having((s) => s.status, 'status', ESignUpStatus.error)
            .having((s) => s.confirmPasswordError, 'confirmError', "Passwords don't match"),
      ],
    );

    // 2. Тест успешной регистрации
    blocTest<SignUpBloc, SignUpState>(
      'emits [loading(true), loading(false), success] when sign up is successful',
      build: () {
        when(() => mockUseCase.call(any(), any()))
            .thenAnswer((_) async => AppAuthCredential(user: UserModel(uid: '123')));
        return signUpBloc;
      },
      seed: () => SignUpState(
        emailText: tEmail,
        passwordText: tPassword,
        confirmText: tPassword,
      ),
      act: (bloc) => bloc.add(SignUpWithPasswordEvent()),
      expect: () => [
        isA<SignUpState>().having((s) => s.isLoading, 'isLoading', true),
        isA<SignUpState>().having((s) => s.isLoading, 'isLoading', false),
        isA<SignUpState>().having((s) => s.status, 'status', ESignUpStatus.success),
      ],
      verify: (_) {
        verify(() => mockUseCase.call(tEmail, tPassword)).called(1);
      },
    );

    // 3. Тест ошибки от сервера (например, "Email is exist")
    blocTest<SignUpBloc, SignUpState>(
      'emits error status when usecase returns failure',
      build: () {
        when(() => mockUseCase.call(any(), any()))
            .thenAnswer((_) async => AppAuthCredential(
                  error: AppError(message: 'Email already exists'),
                ));
        return signUpBloc;
      },
      seed: () => SignUpState(
        emailText: tEmail,
        passwordText: tPassword,
        confirmText: tPassword,
      ),
      act: (bloc) => bloc.add(SignUpWithPasswordEvent()),
      expect: () => [
        isA<SignUpState>().having((s) => s.isLoading, 'isLoading', true),
        isA<SignUpState>().having((s) => s.isLoading, 'isLoading', false),
        isA<SignUpState>()
            .having((s) => s.status, 'status', ESignUpStatus.error)
            .having((s) => s.emailError, 'emailError', 'Email already exists'),
      ],
    );
  });
}