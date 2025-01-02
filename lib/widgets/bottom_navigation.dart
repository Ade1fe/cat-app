import 'package:flutter/material.dart';
import 'package:cat_shop/screens/dashboard_screen.dart';
import 'package:cat_shop/theme/theme.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

import 'package:cat_shop/routes/route_names.dart';

class BottomNavigationApp extends StatelessWidget {
  const BottomNavigationApp({super.key, required this.fullName});

  final String fullName;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: BottomNavigation(fullName: fullName),
    );
  }
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key, required this.fullName});

  final String fullName;

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  late final List<Widget> _pages = [
    DashboardScreen(fullName: widget.fullName),
    const Text('Profile', style: TextStyle(fontSize: 24)),
    const Text('Settings', style: TextStyle(fontSize: 24)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> clearAllPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    log('All preferences have been cleared.');
  }

  void onLogout() async {
    await clearAllPreferences();
    Get.offAllNamed(RouteNames.signIn); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: onLogout,
          icon: const Icon(Icons.menu),
          iconSize: 30,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: CircleAvatar(
                backgroundColor: const Color(0xffE6E6E6),
                radius: 30,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.person),
                  color: Colors.green,
                ),
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle_sharp),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ThemeClass.mainColor,
        onTap: _onItemTapped,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        iconSize: 30,
      ),
    );
  }
}
