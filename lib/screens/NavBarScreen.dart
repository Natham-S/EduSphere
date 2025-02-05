import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// Import your screens
import '../screens/Dashboard.dart';
import '../screens/ProfileScreen.dart';
import '../ui/CustomColorScheme.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int _selectedIndex = 0;

  // List of screens
  final List<Widget> _screens = [
    const Dashboard(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _screens[_selectedIndex], // Dynamically update the screen

          // Floating Glassmorphic Navbar
          Positioned(
            left: 20,
            right: 20,
            bottom: 20, // Adjust this to float above the bottom
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2), // Transparent glass effect
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15,
                        spreadRadius: 3,
                        offset: const Offset(0, 5), // Floating effect
                      ),
                    ],
                  ),
                  child: GNav(
                    rippleColor: Colors.grey[300]!,
                    hoverColor: Colors.grey[100]!,
                    gap: 8,
                    activeColor: customColorScheme.onPrimaryContainer,
                    iconSize: 24,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    duration: const Duration(milliseconds: 300),
                    tabBackgroundColor: Colors.blue.withOpacity(0.2),
                    color: Colors.grey,
                    tabs: const [
                      GButton(
                        icon: Icons.home,
                        text: 'Courses',
                      ),
                      GButton(
                        icon: Icons.person,
                        text: 'Profile',
                      ),
                    ],
                    selectedIndex: _selectedIndex,
                    onTabChange: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
