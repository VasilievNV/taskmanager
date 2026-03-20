import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taskmanager/core/constants/routes.dart';
import 'package:taskmanager/domain/repository/interface/i_auth_repository.dart';
import 'package:taskmanager/domain/use_case/sign_up_with_email_use_case.dart';
import 'package:taskmanager/presentation/ui_component/app_button.dart';
import 'package:taskmanager/presentation/ui_component/app_input.dart';
import 'package:taskmanager/core/src/app_style.dart';
import 'package:taskmanager/core/src/colors.dart';
import 'package:taskmanager/presentation/use_provider/app_loader.dart/notifier/app_loader_provider.dart';
import 'package:taskmanager/presentation/use_provider/theme_mode/notifier/theme_mode_notifier.dart';
import 'package:taskmanager/presentation/use_bloc/sign_up/bloc/sign_up_bloc.dart';
import 'package:taskmanager/presentation/use_bloc/sign_up/bloc/sign_up_event.dart';
import 'package:taskmanager/presentation/use_bloc/sign_up/bloc/sign_up_state.dart';


class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => SignUpWithEmailUseCase(
            repository: context.read<IAuthRepository>()
          )
        )
      ],
      child: BlocProvider(
        create: (context) => SignUpBloc(
          signUpWithEmailUseCase: context.read<SignUpWithEmailUseCase>()
        ),
        child: BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            context.read<AppLoaderNotifier>().setState(state.isLoading);

            if (state.status == ESignUpStatus.success) {
              context.goNamed(RouteNames.home);
            }
          },
          child: SignUpView()
        ),
      ),
    );
  }
}


class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

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
        child: BlocBuilder<SignUpBloc, SignUpState>(
          buildWhen: (previous, current) {
            return !(current.status == ESignUpStatus.editing || 
              current.status == ESignUpStatus.loading || current.status == ESignUpStatus.success);
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
      ),
    );
  }

  Widget _header(BuildContext context) {
    final theme = context.watch<ThemeModeNotifier>().state;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Create Account",
          style: AppStyle.bold(
            fontSize: 18,
            color: theme.colorTextPrimary
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Fill you informarion below or register with \nyour social account.",
          textAlign: TextAlign.center,
          style: AppStyle.normal(
            fontSize: 12,
            color: theme.colorTextSecondary,
          ),
        ),
      ],
    );
  }

  Widget _forms(BuildContext context, SignUpState state) {
    final bloc = context.read<SignUpBloc>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppFormField.email(
          label: "Email",
          onChanged: (text) {
            bloc.add(SignUpEditEmailEvent(text));
          },
          error: state.emailError,
        ),
        const SizedBox(height: 20),
        AppFormField.password(
          label: "Password",
          obscureText: state.obscureTextPassword,
          onChanged: (text) {
            bloc.add(SignUpEditPasswordEvent(text));
          },
          onTapIcon: (value) {
            bloc.add(SignUpObscurePasswordEvent(value));
          },
          error: state.passwordError,
        ),
        const SizedBox(height: 20),
        AppFormField.password(
          label: "Confirm Password",
          obscureText: state.obscureTextConfirm,
          onChanged: (text) {
            bloc.add(SignUpEditConfirmEvent(text));
          },
          onTapIcon: (value) {
            bloc.add(SignUpObscureConfirmEvent(value));
          },
          error: state.confirmPasswordError,
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
          title: "Sign Up",
          heroTag: "sign_up",
          isExpand: true,
          backgroundColor: theme.colorButtonPrimary,
          textColor: theme.colorButtonPrimaryText,
          onPressed: () {
            context.read<SignUpBloc>().add(SignUpWithPasswordEvent());
          }
        ),
        _divider(),
        AppButton.google(
          title: "Continue with Google",
          heroTag: "sign_up_google",
          isExpand: true,
          onPressed: () {

          }
        ),
        const SizedBox(height: 70),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Already have an account? ",
                style: AppStyle.medium(
                  color: theme.colorTextPrimary,
                  fontSize: 13,
                )
              ),
              TextSpan(
                text: "Login",
                recognizer: TapGestureRecognizer()..onTap = () {
                  context.goNamed(RouteNames.login);
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

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              height: 1,
              color: colorDivider,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "Or sign up with",
            style: AppStyle.normal(
              fontSize: 12,
              color: colorDivider
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Divider(
              height: 1,
              color: colorDivider,
            ),
          )
        ],
      ),
    );
  }
}