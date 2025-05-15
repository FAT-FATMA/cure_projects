//import 'package:cure/screens/login_screen.dart';
import 'package:flutter/material.dart';
//import 'package:finalproject/widgets/elevated_button.dart';

/*class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/value.png',
              height: 200,
              fit: BoxFit.contain,
            ),

            SizedBox(height: 30),
            Text(
              'Explore the app',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Stay on top of your health—meds, and doctors, all in one app.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            OutlinedButton(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
                backgroundColor: Colors.black,

                foregroundColor: Colors.white, // <- text color
              ),
              child: Text("Sign In"),
            ),
            SizedBox(height: 10),

            OutlinedButton(
              onPressed: () => Navigator.pushNamed(context, '/signup'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
                backgroundColor: Colors.white30,
                foregroundColor: Colors.black, // <- text color
              ),
              child: Text("Create account"),
            ),
          ],
        ),
      ),
    );
  }
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}*/
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // نأجل شوية بعد عرض الـ context
    await Future.delayed(const Duration(milliseconds: 300));

    if (!mounted) return;

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/home');
    }
    // لو مش مسجل دخول، هيفضل في WelcomeScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/value.png',
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 30),
            const Text(
              'Explore the app',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Stay on top of your health—meds, and doctors, all in one app.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            OutlinedButton(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              child: const Text("Sign In"),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () => Navigator.pushNamed(context, '/signup'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.white30,
                foregroundColor: Colors.black,
              ),
              child: const Text("Create account"),
            ),
          ],
        ),
      ),
    );
  }
}
