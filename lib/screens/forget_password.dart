import 'package:cure/show_massage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cure/widgets/text_feild.dart';

class ForgetpassScreen extends StatelessWidget {
  ForgetpassScreen({super.key});
  String email = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Forgot Password")),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 40),
                Icon(Icons.lock_outline, size: 100),
                SizedBox(height: 20),
                Text(
                  "Reset your password",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Enter your email address and we’ll send you a link to reset your password.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                SizedBox(height: 30),

                TextFeild(
                  textFeildHint: 'Email',
                  isObsecures: false,
                  onChange: (value) {
                    email = value; 
                  },
                ),

                // Handle email input
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (email.isEmpty) {
                        showErrorMessage(context, "Please enter your email");
                        return;
                      }

                      try {
                        await resetpass();
                        showErrorMessage(
                          context,
                          "Reset link sent to your email. Please check your inbox or spam folder.",
                        );
                      } on FirebaseAuthException catch (e) {
                        showErrorMessage(
                          context,
                          e.message ?? 'Something went wrong.',
                        );
                      } catch (e) {
                        showErrorMessage(context, e.toString());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white, // <- text color
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text("Send Reset Link"),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    "Back to Login",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> resetpass() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
