import 'package:cure/screens/map_screen.dart';
import 'package:cure/screens/pill_screen.dart';
import 'package:cure/screens/status_screen.dart';
import 'package:cure/widgets/home_appbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;

  late final List<Widget> _screens = const [
    HospitalsScreen(),
    StatusScreen(),
    MedicinesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppbar(),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'lib/assets/icons/hospital_icon.png',
              width: 24,
              height: 24,
            ),
            activeIcon: Image.asset(
              'lib/assets/icons/hospital_icon.png',
              width: 24,
              height: 24,
              color: const Color(0xFF1363DF),
            ),
            label: 'Hospitals',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'lib/assets/icons/home_icon.png',
              width: 24,
              height: 24,
            ),
            activeIcon: Image.asset(
              'lib/assets/icons/home_icon.png',
              width: 24,
              height: 24,
              color: const Color(0xFF1363DF),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'lib/assets/icons/pill_icon.png',
              width: 24,
              height: 24,
            ),
            activeIcon: Image.asset(
              'lib/assets/icons/pill_icon_colored.png',
              width: 24,
              height: 24,
            ),
            label: 'Medicines',
          ),
        ],
      ),
    );
  }
}
