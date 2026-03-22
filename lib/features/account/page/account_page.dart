import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taskmanager/core/constants/routes.dart';
import 'package:taskmanager/features/auth/domain/repositories/interface/i_auth_repository.dart';
import 'package:taskmanager/features/auth/domain/use_case/sign_out_use_case.dart';
import 'package:taskmanager/core/widgets/app_button.dart';
import 'package:taskmanager/features/account/bloc/account_bloc.dart';
import 'package:taskmanager/features/account/bloc/account_event.dart';
import 'package:taskmanager/features/account/bloc/account_state.dart';
import 'package:taskmanager/use_provider/app_loader.dart/notifier/app_loader_provider.dart';
import 'package:taskmanager/use_provider/theme_mode/notifier/theme_mode_notifier.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => SignOutUseCase(
            repository: context.read<IAuthRepository>()
          )
        )
      ],
      child: BlocProvider(
        create: (context) => AccountBloc(
          signOutUseCase: context.read<SignOutUseCase>()
        ),
        child: BlocListener<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state is AccountLoadingState) {
              context.read<AppLoaderNotifier>().setState(state.loading);
            }

            if (state is AccountSignOutState) {
              context.goNamed(RouteNames.login);
            }
          },
          child: AccountView()
        ),
      ),
    );
  }
}

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeModeNotifier>();
    return Scaffold(
      backgroundColor: theme.state.colorBackgroundPrimary,
      appBar: AppBar(
        title: Text("Account"),
      ),
      body: BlocBuilder<AccountBloc, AccountState>(
        buildWhen: (previous, current) {
          return current is! AccountSignOutState;
        },
        builder: (context, state) {
          return Center(
            child: AppButton.text(
              title: "Sign-Out", 
              onPressed: () {
                context.read<AccountBloc>().add(AccountSignOutEvent());
              }
            ),
          );
        },
      ),
    );
  }
}