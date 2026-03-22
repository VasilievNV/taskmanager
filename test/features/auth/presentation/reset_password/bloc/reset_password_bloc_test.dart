import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taskmanager/features/auth/domain/use_case/reset_password_use_case.dart';
import 'package:taskmanager/features/auth/presentation/reset_password/bloc/reset_password_bloc.dart';
import 'package:taskmanager/features/auth/presentation/reset_password/bloc/reset_password_event.dart';
import 'package:taskmanager/features/auth/presentation/reset_password/bloc/reset_password_state.dart';

class MockResetPasswordUseCase extends Mock implements ResetPasswordUseCase {}

void main() {
  late ResetPasswordBloc bloc;
  late MockResetPasswordUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockResetPasswordUseCase();
    bloc = ResetPasswordBloc(mockUseCase);
  });

  tearDown(() => bloc.close());

  group('ResetPasswordBloc', () {
    const tEmail = 'test@mail.com';

    // 1. Тест ввода текста
    blocTest<ResetPasswordBloc, ResetPasswordState>(
      'emits [ResetPasswordEditing] when email is edited',
      build: () => bloc,
      act: (bloc) => bloc.add(ResetPasswordEditEvent(tEmail)),
      expect: () => [
        isA<ResetPasswordEditing>().having((s) => s.emailText, 'email', tEmail),
      ],
    );

    // 2. Тест провальной валидации (пустой email)
    blocTest<ResetPasswordBloc, ResetPasswordState>(
      'emits [ResetPasswordInitial] with error when email is empty',
      build: () => bloc,
      act: (bloc) => bloc.add(ResetPasswordSendEmailEvent()),
      expect: () => [
        isA<ResetPasswordError>().having((s) => s.emailError, 'error', 'Required'),
      ],
    );

    // 3. Тест успешной отправки
    blocTest<ResetPasswordBloc, ResetPasswordState>(
      'emits [ResetPasswordLoading, ResetPasswordSuccess] when usecase succeeds',
      build: () {
        // Подготавливаем стейт с валидным email
        bloc.add(ResetPasswordEditEvent(tEmail));
        when(() => mockUseCase.call(tEmail)).thenAnswer((_) async => {});
        return bloc;
      },
      skip: 1, // Пропускаем ResetPasswordEditing
      act: (bloc) => bloc.add(ResetPasswordSendEmailEvent()),
      expect: () => [
        isA<ResetPasswordLoading>(),
        isA<ResetPasswordSuccess>(),
      ],
      verify: (_) {
        verify(() => mockUseCase.call(tEmail)).called(1);
      },
    );
  });
}