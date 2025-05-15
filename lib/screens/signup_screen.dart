import 'package:cure/show_massage.dart';
import 'package:cure/widgets/Dropdown.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cure/widgets/text_feild.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cure/widgets/text_feild.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String selectedUserType = 'patient';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "Sign up",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextFeild(
                  textFeildHint: "Enter your name",
                  isObsecures: false,
                  onChange: (value) => name = value.trim(),
                ),
                SizedBox(height: 20),
                UserTypeDropdown(
                  value: selectedUserType,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedUserType = value;
                      });
                    }
                  },
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
                        confirmPassword.isEmpty ||
                        name.isEmpty) {
                      showErrorMessage(context, 'Please fill in all fields.');
                    } else if (password != confirmPassword) {
                      showErrorMessage(context, 'Passwords do not match.');
                    } else {
                      try {
                        await registerUser(name, selectedUserType);
                        // Navigate to home or wherever you want
                        Navigator.pushReplacementNamed(context, '/home');
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
                          showErrorMessage(
                            context,
                            e.message ?? 'Error occurred.',
                          );
                        }
                      } catch (e) {
                        showErrorMessage(context, e.toString());
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
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

  Future<void> registerUser(String name, String userType) async {
    final UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', name);
    await prefs.setString('usertype', userType);
    await prefs.setBool('isLoggedIn', true);
  }

  void showErrorMessage(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}

/*class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  String email = '';
  String password = '';
  String confirmPassword = '';
  String name = '';
  //String userType = selectedUserType;
  TextEditingController nameController = TextEditingController();
  String selectedUserType = '';

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
                  textFeildHint: "Enter your name",
                  isObsecures: false,
                  onChange: (value) {
                    name = value;
                  },
                ),
                SizedBox(height: 20),

                /* DropdownButtonFormField<String>(
              value: selectedUserType,
              decoration: InputDecoration(
                labelText: 'اختر النوع',
                border: OutlineInputBorder(),
              ),
              items: ['patient', 'doctor'].map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedUserType = newValue!;
                });
              },
              
            ),*/
                UserTypeDropdown(
                  value: selectedUserType,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedUserType = value;
                      });
                    }
                  },
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
                    } else if (name.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please enter your name")),
                      );
                      return;
                    } else {
                      try {
                        // Call the registerUser function to create a new user
                        await registerUser("name", "userType");
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

  Future<void> registerUser(String name, String userType) async {
    // Add your registration logic here

    final UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', name);
    await prefs.setString('usertype', userType);
    await prefs.setBool('isLoggedIn', true);
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}*/
