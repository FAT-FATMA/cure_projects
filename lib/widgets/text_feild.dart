import 'package:flutter/material.dart';

class TextFeild extends StatelessWidget {
  String textFeildHint;
  bool isObsecures;
  final Function(String) onChange;
  // Callback function to handle text changes
  //TextEditingController nameController = TextEditingController();
  //String selectedUserType = 'patient'; // أو دكتور

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
        fillColor: Colors.grey.shade200,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
    /* DropdownButton<String>(
  value: selectedUserType,
  onChanged: (String? newValue) {
    setState(() {
      selectedUserType = newValue!;
    });
  },
  items: <String>['patient', 'doctor']
      .map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList(),*/
  }
}
