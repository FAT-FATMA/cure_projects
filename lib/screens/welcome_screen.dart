//import 'package:cure/screens/login_screen.dart';
import 'package:flutter/material.dart';
//import 'package:finalproject/widgets/elevated_button.dart';

class WelcomeScreen extends StatelessWidget {
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
}
