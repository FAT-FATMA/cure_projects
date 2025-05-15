import 'package:flutter/material.dart';

class UserTypeDropdown extends StatelessWidget {
  final String value;
  final Function(String?) onChanged;

  const UserTypeDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: 'Type',
        border: OutlineInputBorder(),
      ),
      onChanged: onChanged,
      items:
          ['patient', 'doctor'].map((String val) {
            return DropdownMenuItem<String>(value: val, child: Text(val));
          }).toList(),
    );
  }
}
