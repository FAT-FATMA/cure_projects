import 'package:cure/screens/add_pill.dart';
import 'package:cure/screens/profile_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  HomeAppbar({super.key});
  String? gender;

  Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return "${prefs.getString('username')}"; // Fallback if null
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      title: Row(
        children: [
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                image: AssetImage("lib/assets/profile_logo.png"),
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 15),
              ),
              FutureBuilder<String>(
                future: getName(),
                builder: (context, snapshot) {
                  return Text(
                    '${snapshot.data?.split(' ').first}👋',
                    style: TextStyle(fontSize: 20),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Image.asset('lib/assets/icons/add_pill.png', width: 30, height: 30),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddPill()),
            );
            if (kDebugMode) {
              print('Notification icon pressed');
            }
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
