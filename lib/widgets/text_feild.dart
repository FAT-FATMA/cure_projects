import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFeild extends StatelessWidget {
  String textFeildHint;
  bool isObsecures;
  final Function(String) onChange;
  // Callback function to handle text changes
  //TextEditingController nameController = TextEditingController();
  //String selectedUserType = 'patient'; 

  TextFeild({
    super.key,
    required this.textFeildHint,
    required this.isObsecures,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isObsecures,
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: textFeildHint,
        fillColor: const Color.fromARGB(255, 197, 219, 255),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
   
  }
}
