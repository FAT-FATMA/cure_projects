import 'package:cure/buisness/medicine/medicine_notifier.dart';
import 'package:cure/screens/appointments_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  Future<String> _getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? 'Guest';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('lib/assets/profile_logo.png'),
            ),
            const SizedBox(height: 10),
            FutureBuilder<String>(
              future: _getName(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                return Text(
                  snapshot.data ?? 'Guest',
                  style: const TextStyle(fontSize: 20),
                );
              },
            ),
            const SizedBox(height: 30),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AppointmentsScreen(),
                  ),
                );
              },
              leading: const Icon(Icons.calendar_today),
              title: const Text('Appointments'),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            const Divider(),
            ListTile(
              onTap: () => _logout(context, ref),
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Sign Out',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    final prefs = await SharedPreferences.getInstance();

    // Medication records are local to this installation; clear them on sign-out
    // so another account using the same device cannot see the previous user's data.
    await ref.read(pillProvider.notifier).clearAllMedicines();

    await prefs.remove('email');
    await prefs.remove('password');
    await prefs.remove('username');
    await prefs.remove('usertype');
    await prefs.setBool('isLoggedIn', false);

    await FirebaseAuth.instance.signOut();

    if (!context.mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }
}
