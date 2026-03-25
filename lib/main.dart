import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/firebase_options.dart';
import 'package:taskmanager/root.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  await GoogleSignIn.instance.initialize();

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(Root(
    prefs: sharedPreferences
  ));
}