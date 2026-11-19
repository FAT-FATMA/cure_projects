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
  final List<Widget> _screens = [
    HospitalsScreen(),
    StatusScreen(),
    MedicinesScreen(),
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool ishome = true,ismap = false, ispill = false;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cure',
      theme: ThemeData(),
      home: Scaffold(
        appBar: HomeAppbar(),
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          items:  [
            
            BottomNavigationBarItem(
              icon: Column(
                children: [
                 Image.asset(
                    'lib/assets/icons/hospital_icon.png',
                    width: 24,
                    height: 24,
                   
                 ),
                  SizedBox(height: 4),
                ],
              ),
              label: 'Hospitals',
              
              activeIcon: Column(
                children: [
                 Image.asset(
                    'lib/assets/icons/hospital_icon.png',
                    width: 24,
                    height: 24,
                    color:const Color(0xFF1363DF)
                    
                 ),
                  SizedBox(height: 8),
                ],
              ),

            ),
              
            BottomNavigationBarItem(
              icon: Column(
                children: [
                 Image.asset(
                    'lib/assets/icons/home_icon.png',
                    width: 24,
                    height: 24,
                   
                 ),
                  SizedBox(height: 4),
                ],
              ),
              label: 'Home',
              
              activeIcon: Column(
                children: [
                 Image.asset(
                    'lib/assets/icons/home_icon.png',
                    width: 24,
                    height: 24,
                    color:const Color(0xFF1363DF)
                    
                 ),
                  SizedBox(height: 8),
                ],
              ),

            ),
              
            BottomNavigationBarItem(
              icon: Column(
                children: [
                 Image.asset(
                    'lib/assets/icons/pill_icon.png',
                    width: 24,
                    height: 24,
                    
                   
                 ),
                  SizedBox(height: 4),
                ],
              ),
              label: 'Hospitals',
              
              activeIcon: Column(
                children: [
                 Image.asset(
                    'lib/assets/icons/pill_icon_colored.png',
                    width: 24,
                    height: 24,
                    
                 ),
                  SizedBox(height: 8),
                ],
              ),

            ),
          ],
        ),
      ),
    );
  }
}
