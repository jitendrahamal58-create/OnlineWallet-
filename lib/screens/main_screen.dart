import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import 'home_screen.dart';
import 'cards_screen.dart';
import 'analytics_screen.dart';
import 'profile_screen.dart';
import '../widgets/wallet_widgets.dart'; // BreathingWidget

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  late final List<Widget> _pages = [
    HomeScreen(
      onProfileTap: () {
        setState(() {
          _currentIndex = 3; 
        });
      },
    ),
    const CardsScreen(),
    const AnalyticsScreen(),
    const ProfileScreen(), 
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 600;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        margin: EdgeInsets.only(
          left: isWide ? screenWidth * 0.2 : 20,
          right: isWide ? screenWidth * 0.2 : 20,
          bottom: 24,
          top: 10,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.primaryNeon,
            unselectedItemColor: AppColors.textSecondary,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              _buildNavItem(Icons.home_filled, 0),
              _buildNavItem(Icons.credit_card, 1),
              _buildNavItem(Icons.insert_chart, 2),
              _buildNavItem(Icons.person, 3),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, int index) {
    final isSelected = _currentIndex == index;
    
    // Animate the active icon to breathe
    Widget iconWidget = Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryNeon.withOpacity(0.15) : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Icon(icon),
    );

    return BottomNavigationBarItem(
      icon: isSelected ? BreathingWidget(child: iconWidget) : iconWidget,
      label: '',
    );
  }
}
