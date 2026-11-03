import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../models/wallet_models.dart';

// --- SEND MONEY SCREEN ---
class SendMoneyScreen extends StatelessWidget {
  const SendMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryNeon),
        title: const Text('Send Money', style: TextStyle(color: AppColors.textPrimary)),
      ),
      body: const Center(
        child: Text('Send Money Process', style: TextStyle(color: AppColors.textPrimary, fontSize: 24)),
      ),
    );
  }
}

// --- REQUEST MONEY SCREEN ---
class RequestMoneyScreen extends StatelessWidget {
  const RequestMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryNeon),
        title: const Text('Request Money', style: TextStyle(color: AppColors.textPrimary)),
      ),
      body: const Center(
        child: Text('Request Money Process', style: TextStyle(color: AppColors.textPrimary, fontSize: 24)),
      ),
    );
  }
}

// --- TRANSACTION DETAIL SCREEN ---
class TransactionDetailScreen extends StatelessWidget {
  final Transaction transaction;

  const TransactionDetailScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryNeon),
        title: const Text('Transaction Details', style: TextStyle(color: AppColors.textPrimary)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(transaction.imageUrl),
              backgroundColor: AppColors.surfaceLight,
            ),
            const SizedBox(height: 24),
            Text(
              transaction.merchant,
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              transaction.category,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 16),
            ),
            const SizedBox(height: 32),
            Text(
              '${transaction.isIncome ? '+' : '-'}\$${transaction.amount.toStringAsFixed(2)}',
              style: TextStyle(
                color: transaction.isIncome ? AppColors.primaryNeon : AppColors.textPrimary,
                fontSize: 48,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              transaction.date,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 16),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // e.g. Report an issue
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Report an Issue', style: TextStyle(color: AppColors.textPrimary, fontSize: 16)),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// --- NOTIFICATIONS SCREEN ---
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryNeon),
        title: const Text('Notifications', style: TextStyle(color: AppColors.textPrimary)),
      ),
      body: const Center(
        child: Text('No new notifications', style: TextStyle(color: AppColors.textSecondary, fontSize: 18)),
      ),
    );
  }
}

// --- SEARCH SCREEN ---
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryNeon),
        title: TextField(
          style: const TextStyle(color: AppColors.textPrimary),
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search transactions...',
            hintStyle: TextStyle(color: AppColors.textSecondary.withOpacity(0.5)),
            border: InputBorder.none,
          ),
        ),
      ),
      body: const Center(
        child: Text('Search results will appear here', style: TextStyle(color: AppColors.textSecondary, fontSize: 18)),
      ),
    );
  }
}
