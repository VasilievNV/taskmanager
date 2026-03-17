import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/domain/use_case/account_case.dart';
import 'package:taskmanager/presentation/use_bloc/account/bloc/account_event.dart';
import 'package:taskmanager/presentation/use_bloc/account/bloc/account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountCase account;

  AccountBloc(this.account) : super(AccountInitState()) {
    on<AccountSignOutEvent>((event, emit) async {
      await account.repository.signOut();
      emit(AccountSignOutState());
    });
  }
}