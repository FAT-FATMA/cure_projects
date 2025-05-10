import 'package:flutter/material.dart';

void showErrorMessage(BuildContext context, String message) {
  // Show error message to the user
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.red));
}
