import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

// --- PERSONAL INFORMATION SCREEN ---
class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryNeon),
        title: const Text('Personal Information', style: TextStyle(color: AppColors.textPrimary)),
      ),
      body: const Center(
        child: Text('Edit Personal Info Here', style: TextStyle(color: AppColors.textPrimary, fontSize: 20)),
      ),
    );
  }
}

// --- PAYMENT METHODS SCREEN ---
class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryNeon),
        title: const Text('Payment Methods', style: TextStyle(color: AppColors.textPrimary)),
      ),
      body: const Center(
        child: Text('Manage Payment Methods', style: TextStyle(color: AppColors.textPrimary, fontSize: 20)),
      ),
    );
  }
}

// --- SECURITY & PRIVACY SCREEN ---
class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryNeon),
        title: const Text('Security & Privacy', style: TextStyle(color: AppColors.textPrimary)),
      ),
      body: const Center(
        child: Text('Security Settings', style: TextStyle(color: AppColors.textPrimary, fontSize: 20)),
      ),
    );
  }
}

// --- INVITE FRIENDS SCREEN ---
class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryNeon),
        title: const Text('Invite Friends', style: TextStyle(color: AppColors.textPrimary)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.group_add, color: AppColors.primaryNeon, size: 80),
            const SizedBox(height: 24),
            const Text(
              'Share your code:',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 18),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primaryNeon.withOpacity(0.5)),
              ),
              child: const Text(
                'NOVA-2026',
                style: TextStyle(color: AppColors.primaryNeon, fontSize: 32, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
