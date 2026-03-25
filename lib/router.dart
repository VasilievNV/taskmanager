import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskmanager/core/constants/route_names.dart';
import 'package:taskmanager/core/widgets/navigation_bar.dart';
import 'package:taskmanager/features/account/page/account_page.dart';
import 'package:taskmanager/features/auth/presentation/login/page/login_page.dart';
import 'package:taskmanager/features/auth/presentation/reset_password/page/reset_password_page.dart';
import 'package:taskmanager/features/auth/presentation/sign_up/page/sign_up_page.dart';
import 'package:taskmanager/features/calendar/calendar_page.dart';
import 'package:taskmanager/features/chat/chat_page.dart';
import 'package:taskmanager/features/home/home_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();


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
              backgroundColor: Theme.of(context).colorScheme.surface,
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