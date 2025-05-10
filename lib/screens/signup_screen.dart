import 'package:cure/show_massage.dart';
import 'package:cure/widgets/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cure/widgets/text_feild.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  String email = '';
  String password = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign up")),
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Sign up",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextFeild(
                  textFeildHint: 'Email',
                  isObsecures: false,
                  onChange: (value) => email = value.trim(),
                ),
                SizedBox(height: 20),
                TextFeild(
                  textFeildHint: 'Create a password',
                  isObsecures: true,
                  onChange: (value) => password = value.trim(),
                ),
                SizedBox(height: 20),
                TextFeild(
                  textFeildHint: 'Confirm password',
                  isObsecures: true,
                  onChange: (value) => confirmPassword = value.trim(),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (email.isEmpty ||
                        password.isEmpty ||
                        confirmPassword.isEmpty) {
                      showErrorMessage(context, 'Please fill in all fields.');
                    } else if (password != confirmPassword) {
                      showErrorMessage(context, 'Passwords do not match.');
                    } else {
                      try {
                        // Call the registerUser function to create a new user
                        await registerUser();
                        /* Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const MyHomePage())
                        );*/
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showErrorMessage(
                            context,
                            'The password provided is too weak.',
                          );
                        } else if (e.code == 'email-already-in-use') {
                          showErrorMessage(
                            context,
                            'The account already exists for that email.',
                          );
                        } else {
                          showErrorMessage(context, e.message!);
                        }
                      } catch (e) {
                        showErrorMessage(context, e.toString());
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text("Sign up"),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Or Register with'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.facebook, size: 30, color: Color(0xff1877f2)),
                    Icon(Icons.g_mobiledata, size: 40),
                    Icon(Icons.apple, size: 30),
                  ],
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/login'),
                  child: Text(
                    "Already have an account? Log in",
                    style: TextStyle(color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    // Add your registration logic here

    final UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }
}
