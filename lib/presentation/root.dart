import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/core/constants/routes.dart';
import 'package:taskmanager/presentation/use_provider/navigation_bar/view/navigation_bar.dart';
import 'package:taskmanager/presentation/use_bloc/account/view/account_page.dart';
import 'package:taskmanager/presentation/use_bloc/calendar/calendar_page.dart';
import 'package:taskmanager/presentation/use_bloc/chat/chat_page.dart';
import 'package:taskmanager/presentation/use_provider/navigation_bar/notifier/navigation_bar_notifier.dart';
import 'package:taskmanager/presentation/use_provider/theme_mode/notifier/theme_mode_notifier.dart';
import 'use_bloc/login/view/login_page.dart';
import 'use_bloc/home/home_page.dart';
import 'use_bloc/sign_up/view/sign_up_page.dart';


final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavigationBarNotifier()),
        ChangeNotifierProvider(create: (context) => ThemeModeNotifier())
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
        routerConfig: routerConfig,
      ),
    );
  }
}

final GoRouter routerConfig = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: "/login",
  redirect: (context, state) async {
    final user = FirebaseAuth.instance.currentUser;
  
    // 1. Проверяем, на «публичной» ли мы странице (логин или регистрация)
    final isLoggingIn = state.matchedLocation == '/login';
    final isSigningUp = state.matchedLocation == '/sign_in';
    final isAuthPage = isLoggingIn || isSigningUp;

    // 2. Если юзера нет и он НЕ на странице входа — гоним на логин
    if (user == null) {
      return isAuthPage ? null : "/login";
    }

    // 3. Если юзер ЗАЛОГИНЕН и зачем-то зашел на логин/регистрацию — гоним домой
    if (isAuthPage) {
      return "/home";
    }

    // В остальных случаях (юзер есть и идет на защищенный роут) — всё ок
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
      }
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
        final navBar = context.watch<NavigationBarNotifier>();
        final theme = context.watch<ThemeModeNotifier>();

        return CustomTransitionPage(
          child: Scaffold(
            body: child,
            bottomNavigationBar: AppNavigationBar(
              backgroundColor: theme.state.colorBackgroundPrimary,
              selectedIndex: navBar.state.index,
              onSelected: (index) {
                switch (index) {
                  case 0:
                    navBar.setState(index);
                    context.goNamed(RouteNames.home);
                  case 1:
                    navBar.setState(index);
                    context.goNamed(RouteNames.calendar);
                  case 2:
                    context.pushNamed(RouteNames.chat);
                  case 3:
                    context.pushNamed(RouteNames.account);
                  default:
                    throw Exception("PAGE NOT FOUND!");    
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
      ]
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
);