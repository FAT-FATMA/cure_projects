import 'package:cure/firebase_options.dart';
import 'package:cure/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cure/screens/welcome_screen.dart';
import 'package:cure/screens/login_screen.dart';
import 'package:cure/screens/forget_password.dart';
import 'package:cure/screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
      routes: {
        '/signup': (context) => SignupScreen(),
        '/login': (context) => LoginScreen(),
        '/forgot-password': (context) => ForgetpassScreen(),
      },
    );
  }
}
