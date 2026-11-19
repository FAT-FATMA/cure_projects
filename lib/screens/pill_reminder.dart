import 'package:flutter/material.dart';

class PillReminderScreen extends StatelessWidget {
  const PillReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pill Reminder')),
      body: Center(child: Text('Pill Reminder Screen')),
    );
  }
}
