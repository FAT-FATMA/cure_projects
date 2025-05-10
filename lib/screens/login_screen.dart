import 'package:cure/show_massage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cure/widgets/text_feild.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hi, Welcome! 👋")),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Log in",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextFeild(
                  textFeildHint: 'Email',
                  isObsecures: false,
                  onChange: (value) => email = value,
                ),
                SizedBox(height: 20),
                TextFeild(
                  textFeildHint: 'Password',
                  isObsecures: true,
                  onChange: (value) => password = value,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(value: true, onChanged: (_) {}),
                        Text("Remember me"),
                      ],
                    ),
                    GestureDetector(
                      onTap:
                          () =>
                              Navigator.pushNamed(context, '/forgot-password'),
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (email.isEmpty || password.isEmpty) {
                      showErrorMessage(context, 'Please fill in all fields.');
                      return;
                    }

                    try {
                      await loginUser();

                      //  Show message after successful login
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Login successful! Welcome back, $email',
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );

                      //  Navigate to home if available (تقدري تفعلي دي لما تجهزي صفحة Home)
                      // Navigator.pushNamed(context, '/home');
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        showErrorMessage(
                          context,
                          'No user found for that email.',
                        );
                      } else if (e.code == 'wrong-password') {
                        showErrorMessage(context, 'Wrong password provided.');
                      } else {
                        showErrorMessage(context, e.message ?? 'Login failed');
                      }
                    } catch (e) {
                      showErrorMessage(context, e.toString());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Log in"),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('OR'),
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
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/signup'),
                    child: Text(
                      "Don’t have an account? Sign up",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
