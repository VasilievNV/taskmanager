import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taskmanager/core/constants/route_names.dart';
import 'package:taskmanager/core/theme/app_color_theme.dart';
import 'package:taskmanager/features/auth/domain/repositories/interface/i_auth_repository.dart';
import 'package:taskmanager/features/auth/domain/use_case/login_with_email_use_case.dart';
import 'package:taskmanager/features/auth/domain/use_case/login_with_google_use_case.dart';
import 'package:taskmanager/features/auth/presentation/login/bloc/login_state.dart';
import 'package:taskmanager/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:taskmanager/core/widgets/app_button.dart';
import 'package:taskmanager/core/widgets/app_input.dart';
import 'package:taskmanager/features/auth/presentation/login/bloc/login_event.dart';
import 'package:taskmanager/core/src/app_style.dart';
import 'package:taskmanager/core/widgets/app_loader.dart/notifier/app_loader_provider.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => LoginWithEmailUseCase(
            repository: context.read<IAuthRepository>(), 
          ),
        ),
        RepositoryProvider(
          create: (context) => LoginWithGoogleUseCase(
            repository: context.read<IAuthRepository>()
          ),
        )
      ],
      child: BlocProvider(
        create: (context) => LoginBloc(
          loginWithEmailUseCase: context.read<LoginWithEmailUseCase>(),
          loginWithGoogleUseCase: context.read<LoginWithGoogleUseCase>()
        ),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            context.read<AppLoaderNotifier>().setState(state.isLoading);

            if (state.status == LoginStatus.success) {
              context.goNamed(RouteNames.home);
            }
          },
          child: LoginView()
        ),
      ),
    );
  }  
}


class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 30
        ),
        child: BlocBuilder<LoginBloc, LoginState>(
          buildWhen: (previous, current) {
            const statuses = [LoginStatus.success, LoginStatus.editing, LoginStatus.loading];
            return !statuses.contains(current.status);
          },
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                _header(context),
                const SizedBox(height: 30),
                _forms(context, state),
                const SizedBox(height: 20),
                _buttons(context)
              ],
            );
          }
        ),
      )
    );
  }

  Widget _header(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorTheme>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Login",
          style: AppStyle.bold(
            fontSize: 18,
            color: theme?.textPrimary
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Welcome back - log in to manage your \ntasks effortlessly.",
          textAlign: TextAlign.center,
          style: AppStyle.normal(
            fontSize: 12,
            color: theme?.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _forms(BuildContext context, LoginState state) {
    final loginBloc = context.read<LoginBloc>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppFormField.email(
          label: "Email",
          onChanged: (text) {
            loginBloc.add(LoginEditEmailEvent(text));
          },
          error: state.emailError,
        ),
        const SizedBox(height: 20),
        AppFormField.password(
          label: "Password",
          obscureText: state.obscureText,
          onChanged: (text) {
            loginBloc.add(LoginEditPasswordEvent(text));
          },
          onTapIcon: (value) {
            loginBloc.add(LoginObscurePasswordEvent(value));
          },
          error: state.passwordError,
        ),
      ],
    );
  }

  Widget _buttons(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorTheme>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppButton.primary(
          title: "Login",
          isExpand: true,
          heroTag: "login",
          backgroundColor: theme?.buttonPrimary,
          onPressed: () {
            context.read<LoginBloc>().add(LoginWithPasswordEvent());
          }
        ),
        const SizedBox(height: 25),
        AppButton.text(
          title: "Forget password?",
          color: theme?.textSecondary,
          onPressed: () {
            context.goNamed(RouteNames.resetPassword);
          }
        ),
        const SizedBox(height: 25),
        AppButton.google(
          title: "Continue with Google",
          heroTag: "login_google",
          isExpand: true,
          onPressed: () {
            context.read<LoginBloc>().add(LoginWithGoogleEvent());
          }
        ),
        const SizedBox(height: 70),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Don't have an account? ",
                style: AppStyle.medium(
                  color: theme?.textPrimary,
                  fontSize: 13,
                )
              ),
              TextSpan(
                text: "Sign-In",
                recognizer: TapGestureRecognizer()..onTap = () {
                  context.goNamed(RouteNames.signUp);
                },
                style: AppStyle.medium(
                  color: theme?.textLink,
                  fontSize: 13,
                  decoration: TextDecoration.underline
                )
              )
            ]
          )
        )
      ],
    );
  }
}