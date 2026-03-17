sealed class AccountState {}

class AccountInitState extends AccountState {}

class AccountLoadingState extends AccountState {
  final bool loading;

  AccountLoadingState(this.loading);
}

class AccountSignOutState extends AccountState {}