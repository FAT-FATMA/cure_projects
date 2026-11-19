import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/Logo.png',
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
              onPressed: () => Navigator.popAndPushNamed(context, '/login'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Color(0xff1877f2),
                foregroundColor: Colors.white,
              ),
              child: const Text("Sign In"),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () => Navigator.popAndPushNamed(context, '/signup'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.white30,
                foregroundColor: Color(0xff1877f2),
              ),
              child: const Text("Create account"),
            ),
          ],
        ),
      ),
    );
  }
}
