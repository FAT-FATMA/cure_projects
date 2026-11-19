import 'package:cure/main.dart';
import 'package:cure/screens/appointments_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../buisness/medicine/medicine_notifier.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) { // Added WidgetRef parameter
    Future<String> getName() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('username') ?? 'Guest'; // Added fallback
    }

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
              future: getName(),
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
                  MaterialPageRoute(builder: (_) => const AppointmentsScreen()),
                );
              },
              leading: const Icon(Icons.calendar_today),
              title: const Text('Appointments'),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            const Divider(),
            ListTile(
              onTap: () => _logout(context, ref), // Pass ref directly
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




  Future<void> _logout(context,ref) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    ref.read(pillProvider.notifier).clearAllMedicines(); // Clear all pills from the provider
    await prefs.remove('email');
    await prefs.remove('password');
    await prefs.setBool('isLoggedIn', false);
    await FirebaseAuth.instance.signOut();
   Navigator.of(context).popUntil((route) => false); // Clear all routes
   runApp(ProviderScope(child:Cure()));
  }
 
}
