import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cure/widgets/text_feild.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hi, Welcome! 👋",
          style: TextStyle(color: Color(0xff1877f2)),
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
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
                  onChange: (value) => email = value.trim(),
                ),
                SizedBox(height: 20),
                TextFeild(
                  textFeildHint: 'Password',
                  isObsecures: true,
                  onChange: (value) => password = value.trim(),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (email.isEmpty || password.isEmpty) {
                      showErrorMessage(context, 'Please fill in all fields.');
                      return;
                    }

                    try {
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                      final user = credential.user;
                      if (user == null) {
                        throw StateError('Unable to load the signed-in account.');
                      }

                      final prefs = await SharedPreferences.getInstance();
                      final savedName = prefs.getString('username_${user.uid}');
                      final savedUserType = prefs.getString('usertype_${user.uid}') ?? 'patient';

                      await prefs.setString(
                        'username',
                        savedName ?? user.displayName ?? email.split('@').first,
                      );
                      await prefs.setString('usertype', savedUserType ?? 'patient');
                      await prefs.setBool('isLoggedIn', true);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Login successful! Welcome back, $email',
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );

                      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        showErrorMessage(
                          context,
                          'No user found for that email.',
                        );
                      } else if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
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
                    backgroundColor: Color(0xff1877f2),
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
                    onTap: () => Navigator.popAndPushNamed(context, '/signup'),

                    child: Text(
                      "Don’t have an account? Sign up",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),

                Center(
                  child: GestureDetector(
                    onTap:
                        () => Navigator.pushNamed(context, '/forgot-password'),
                    child: Text(
                      "Forgot password?",
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

  void showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
}
