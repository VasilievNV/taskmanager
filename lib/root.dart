import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/core/theme/app_color_theme.dart';
import 'package:taskmanager/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:taskmanager/features/auth/data/repositories/Impl/auth_repository.dart';
import 'package:taskmanager/features/auth/domain/repositories/interface/i_auth_repository.dart';
import 'package:taskmanager/core/widgets/app_loader.dart/notifier/app_loader_provider.dart';
import 'package:taskmanager/core/widgets/app_loader.dart/view/app_loader_wrapper.dart';
import 'package:taskmanager/core/theme/theme_mode_notifier.dart';
import 'package:taskmanager/router.dart';


class Root extends StatelessWidget {
  final SharedPreferences prefs;

  const Root({super.key, required this.prefs});

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
          ChangeNotifierProvider(create: (context) => ThemeModeNotifier(prefs)),
          ChangeNotifierProvider(create: (context) => AppLoaderNotifier())
        ],
        child: Consumer<ThemeModeNotifier>(
          builder: (context, value, child) {
            final themeMode = context.watch<ThemeModeNotifier>().themeMode;

            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              themeAnimationCurve: Curves.decelerate,
              themeMode: themeMode,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.white,
                  dynamicSchemeVariant: DynamicSchemeVariant.monochrome
                ),
                scaffoldBackgroundColor: Colors.white,
                inputDecorationTheme: AppInputDecorationTheme.light,
                extensions: [AppThemes.light],
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.white,
                  brightness: Brightness.dark,
                  dynamicSchemeVariant: DynamicSchemeVariant.monochrome,
                ),
                scaffoldBackgroundColor: Colors.black,
                inputDecorationTheme: AppInputDecorationTheme.dark,
                extensions: [AppThemes.dark],
                useMaterial3: true,
              ),
              builder: (context, child) {
                return GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: AppLoaderWrapper(child: child)
                );
              },
              routerConfig: routerConfig,
            );
          },
        ),
      ),
    );
  }
}

