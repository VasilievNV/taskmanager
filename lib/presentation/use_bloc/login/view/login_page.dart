import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taskmanager/core/constants/routes.dart';
import 'package:taskmanager/domain/repository/Impl/login_repository.dart';
import 'package:taskmanager/domain/use_case/login_case.dart';
import 'package:taskmanager/presentation/ui_component/app_loader.dart';
import 'package:taskmanager/presentation/use_bloc/login/bloc/login_state.dart';
import 'package:taskmanager/presentation/use_bloc/login/bloc/login_bloc.dart';
import 'package:taskmanager/presentation/ui_component/app_button.dart';
import 'package:taskmanager/presentation/ui_component/app_input.dart';
import 'package:taskmanager/presentation/use_bloc/login/bloc/login_event.dart';
import 'package:taskmanager/core/src/app_style.dart';
import 'package:taskmanager/presentation/use_provider/theme_mode/notifier/theme_mode_notifier.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (BuildContext context) => LoginCase(
        repository: LoginRepository(instance: FirebaseAuth.instance)
      ),
      child: BlocProvider(
        create: (context) => LoginBloc(context.read<LoginCase>()),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginLoadingState) {
              if (state.loading) {
                AppLoader.show(context);
              } else {
                AppLoader.hide(context);
              }
            }

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
    final theme = context.watch<ThemeModeNotifier>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: theme.state.colorBackgroundPrimary,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 30
        ),
        child: BlocBuilder<LoginBloc, LoginState>(
          buildWhen: (previous, current) {
            return !(current.status == LoginStatus.success || current is LoginLoadingState);
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
    final theme = context.watch<ThemeModeNotifier>().state;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Login",
          style: AppStyle.bold(
            fontSize: 18,
            color: theme.colorTextPrimary
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Welcome back - log in to manage your \ntasks effortlessly.",
          textAlign: TextAlign.center,
          style: AppStyle.normal(
            fontSize: 12,
            color: theme.colorTextSecondary,
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
    final theme = context.watch<ThemeModeNotifier>().state;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppButton.primary(
          title: "Login",
          isExpand: true,
          heroTag: "login",
          backgroundColor: theme.colorButtonPrimary,
          textColor: theme.colorButtonPrimaryText,
          onPressed: () {
            context.read<LoginBloc>().add(LoginWithPasswordEvent());
          }
        ),
        const SizedBox(height: 25),
        AppButton.text(
          title: "Forget password?",
          color: theme.colorTextLink,
          onPressed: () {
            
          }
        ),
        const SizedBox(height: 25),
        AppButton.google(
          title: "Continue with Google",
          heroTag: "login_google",
          isExpand: true,
          onPressed: () {

          }
        ),
        const SizedBox(height: 70),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Don't have an account? ",
                style: AppStyle.medium(
                  color: theme.colorTextPrimary,
                  fontSize: 13,
                )
              ),
              TextSpan(
                text: "Sign-In",
                recognizer: TapGestureRecognizer()..onTap = () {
                  context.goNamed(RouteNames.signUp);
                },
                style: AppStyle.medium(
                  color: theme.colorTextLink,
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