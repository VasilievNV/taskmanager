import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/core/constants/routes.dart';
import 'package:taskmanager/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:taskmanager/features/auth/domain/repositories/Impl/auth_repository.dart';
import 'package:taskmanager/features/auth/domain/repositories/interface/i_auth_repository.dart';
import 'package:taskmanager/features/auth/presentation/reset_password/page/reset_password_page.dart';
import 'package:taskmanager/use_provider/app_loader.dart/notifier/app_loader_provider.dart';
import 'package:taskmanager/use_provider/app_loader.dart/view/app_loader_wrapper.dart';
import 'package:taskmanager/core/widgets/navigation_bar.dart';
import 'package:taskmanager/features/account/page/account_page.dart';
import 'package:taskmanager/features/calendar/calendar_page.dart';
import 'package:taskmanager/features/chat/chat_page.dart';
import 'package:taskmanager/use_provider/theme_mode/notifier/theme_mode_notifier.dart';
import 'features/auth/presentation/login/page/login_page.dart';
import 'features/home/home_page.dart';
import 'features/auth/presentation/sign_up/page/sign_up_page.dart';


final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<IAuthRepository>(
          create: (context) => AuthRepository(
            dataSource: AuthRemoteDataSource(
              firebaseAuth: FirebaseAuth.instance,
              googleSignIn: GoogleSignIn.instance
            )
          ),
        ),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeModeNotifier()),
          ChangeNotifierProvider(create: (context) => AppLoaderNotifier())
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          themeAnimationCurve: Curves.decelerate,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.white,
              dynamicSchemeVariant: DynamicSchemeVariant.monochrome
            ),
          ),
          builder: (context, child) {
            return GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: AppLoaderWrapper(child: child)
            );
          },
          routerConfig: routerConfig,
        ),
      ),
    );
  }
}

final GoRouter routerConfig = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: "/login",
  redirect: (context, state) async {
    final user = FirebaseAuth.instance.currentUser;
  
    final isLoggingIn = state.matchedLocation == '/login';
    final isSigningUp = state.matchedLocation == '/sign_in';
    final isResetPassword = state.matchedLocation == '/login/reset_password';
    final isAuthPage = isLoggingIn || isSigningUp || isResetPassword;

    if (user == null) {
      return isAuthPage ? null : "/login";
    }

    if (isAuthPage) {
      return "/home";
    }

    return null;
  },
  routes: [
    GoRoute(
      name: RouteNames.login,
      path: "/login",
      //builder: (context, stage) => const LoginPage(),
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
        );
      },
      routes: [
        GoRoute(
          name: RouteNames.resetPassword,
          path: "/reset_password",
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const ResetPasswordPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
            );
          },
        )
      ]
    ),
    GoRoute(
      name: RouteNames.signUp,
      path: "/sign_in",
      //builder: (context, state) => const SignUpPage()
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const SignUpPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
        );
      }
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state, child) {
        final theme = context.watch<ThemeModeNotifier>();

        final String location = state.uri.toString();
        
        int currentIndex = 0;
        
        if (location.startsWith('/calendar')) {
          currentIndex = 1;
        } else if (location.startsWith('/chat')) {
          currentIndex = 2;
        } else if (location.startsWith('/account')) {
          currentIndex = 3;
        }

        return CustomTransitionPage(
          child: Scaffold(
            body: child,
            bottomNavigationBar: AppNavigationBar(
              backgroundColor: theme.state.colorBackgroundPrimary,
              selectedIndex: currentIndex,
              onSelected: (index) {
                switch (index) {
                  case 0: 
                    context.goNamed(RouteNames.home); 
                    break;
                  case 1: 
                    context.goNamed(RouteNames.calendar); 
                    break;
                  case 2: 
                    context.goNamed(RouteNames.chat); 
                    break;
                  case 3: 
                    context.goNamed(RouteNames.account); 
                    break;
                }
              },
            ),
          ), 
          transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
        );
      },
      routes: [
        GoRoute(
          name: RouteNames.home,
          path: "/home",
          //builder: (context, stage) => const HomePage()
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const HomePage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
            );
          }
        ),
        GoRoute(
          name: RouteNames.calendar,
          path: "/calendar",
          //builder: (context, stage) => const CalendarPage()
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const CalendarPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
            );
          },
        ),
        GoRoute(
          name: RouteNames.chat,
          path: "/chat",
          //builder: (context, stage) => const ChatPage()
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const ChatPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
            );
          },
        ),
        GoRoute(
          name: RouteNames.account,
          path: "/account",
          //builder: (context, stage) => const AccountPage()
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const AccountPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
            );
          },
        ),
      ]
    ),
  ]
);