import 'package:flutter/material.dart';
import '../core/theme/store_colors.dart';
import 'store_home_screen.dart';
import 'store_cart_screen.dart';
import 'store_profile_screen.dart';
import 'store_login_screen.dart'; // Just imported for reference if needed

class StoreMainScreen extends StatefulWidget {
  const StoreMainScreen({super.key});

  @override
  State<StoreMainScreen> createState() => _StoreMainScreenState();
}

class _StoreMainScreenState extends State<StoreMainScreen> {
  int _currentIndex = 1; // Default to 'Shop Glow'

  final List<Widget> _pages = [
    // Smart Home Dashboard (placeholder for connected devices)
    const Scaffold(body: Center(child: Text("Smart Home Hub", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)))),
    const StoreHomeScreen(),
    const StoreCartScreen(),
    const StoreProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StoreColors.background,
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.blue.withOpacity(0.2),
          labelTextStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87);
            }
            return const TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black54);
          }),
        ),
        child: NavigationBar(
          backgroundColor: const Color(0xFFF3F4F6),
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Smart Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.storefront_outlined),
              selectedIcon: Icon(Icons.storefront),
              label: 'Shop Glow',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_bag_outlined),
              selectedIcon: Icon(Icons.shopping_bag),
              label: 'Cart',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
