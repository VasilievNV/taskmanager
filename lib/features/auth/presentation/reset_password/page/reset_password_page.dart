import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/core/src/app_style.dart';
import 'package:taskmanager/core/theme/app_color_theme.dart';
import 'package:taskmanager/features/auth/domain/repositories/interface/i_auth_repository.dart';
import 'package:taskmanager/features/auth/domain/use_case/reset_password_use_case.dart';
import 'package:taskmanager/core/widgets/app_button.dart';
import 'package:taskmanager/core/widgets/app_input.dart';
import 'package:taskmanager/features/auth/presentation/reset_password/bloc/reset_password_bloc.dart';
import 'package:taskmanager/features/auth/presentation/reset_password/bloc/reset_password_event.dart';
import 'package:taskmanager/features/auth/presentation/reset_password/bloc/reset_password_state.dart';
import 'package:taskmanager/core/widgets/app_loader.dart/notifier/app_loader_provider.dart';


class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ResetPasswordUseCase(
        repository: context.read<IAuthRepository>()
      ),
      child: BlocProvider(
        create: (context) => ResetPasswordBloc(context.read<ResetPasswordUseCase>()),
        child: BlocListener<ResetPasswordBloc, ResetPasswordState>(
          listenWhen: (previous, current) {
            return current is! ResetPasswordEditing;
          },
          listener: (context, state) {
            context.read<AppLoaderNotifier>().setState(state.isLoading);
          },
          child: ResetPasswordView(),
        ),
      ),
    );
  }
}

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      //backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text("Back to Login"),
      ),
      body: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
        buildWhen: (previous, current) {
          return !(current is ResetPasswordLoading || current is ResetPasswordSuccess);
        },
        builder: (context, state) {
          final bloc = context.read<ResetPasswordBloc>();
          final theme = Theme.of(context).extension<AppColorTheme>();

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 30
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Reset password",
                  style: AppStyle.bold(
                    fontSize: 20,
                    color: theme?.textPrimary
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Enter your email address and we'll send you a link to reset your password",
                  style: AppStyle.normal(
                    fontSize: 14,
                    color: theme?.textSecondary
                  ),
                ),
                const SizedBox(height: 15),
                AppFormField.email(
                  label: "Email",
                  error: state.emailError,
                  onChanged: (text) => bloc.add(ResetPasswordEditEvent(text)),
                ),
                const SizedBox(height: 20),
                AppButton.primary(
                  isExpand: true,
                  title: "Send Reset Link",
                  backgroundColor: theme?.buttonPrimary,
                  onPressed: () => bloc.add(ResetPasswordSendEmailEvent())
                )
              ],
            ),
          );
        },
      ),
    );
  }
}