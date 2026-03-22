import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/features/auth/domain/use_case/sign_out_use_case.dart';
import 'package:taskmanager/features/account/bloc/account_event.dart';
import 'package:taskmanager/features/account/bloc/account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final SignOutUseCase signOutUseCase;

  AccountBloc({
    required this.signOutUseCase
  }) : super(AccountInitState()) {
    on<AccountSignOutEvent>((event, emit) async {
      await signOutUseCase.call();
      emit(AccountSignOutState());
    });
  }
}