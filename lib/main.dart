
import 'package:cure/services/firebase_options.dart';
import 'package:cure/screens/home_screen.dart';
import 'package:cure/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cure/screens/login_screen.dart';
import 'package:cure/screens/forget_password.dart';
import 'package:cure/screens/signup_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(ProviderScope(child:Cure()));

}

class Cure extends StatelessWidget {
  const Cure({super.key});

  Future<bool> _isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: _isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: snapshot.data! ? HomeScreen() : WelcomeScreen(),
            routes: {
              '/signup': (context) => SignUpScreen(),
              '/login': (context) => LoginScreen(),
              '/forgot-password': (context) => ForgetpassScreen(),
              '/home': (context) => HomeScreen(),
            },
          );
        },
      ),
    );
  }
}
