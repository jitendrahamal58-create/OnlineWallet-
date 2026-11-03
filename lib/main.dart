import 'package:flutter/material.dart';
import 'core/theme/app_colors.dart';
import 'screens/onboarding_screen.dart';

void main() {
  runApp(const MobileWalletApp());
}

class MobileWalletApp extends StatelessWidget {
  const MobileWalletApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neon Wallet App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryNeon,
          secondary: AppColors.secondaryDark,
          surface: AppColors.surface,
        ),
        useMaterial3: true,
      ),
      home: const OnboardingScreen(), 
    );
  }
}
