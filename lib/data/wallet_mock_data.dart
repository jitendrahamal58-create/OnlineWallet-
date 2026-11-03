import 'package:flutter/material.dart';
import '../models/wallet_models.dart';
import '../core/theme/app_colors.dart';

class WalletMockData {
  static final UserProfile user = UserProfile(
    name: 'Sophie Laurent',
    avatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=150&q=80',
  );

  static final List<BankCard> myCards = [
    BankCard(
      id: 'c1',
      type: 'VISA',
      lastFour: '4289',
      balance: 18125.00,
      color: AppColors.primaryNeon,
    ),
    BankCard(
      id: 'c2',
      type: 'Mastercard',
      lastFour: '8990',
      balance: 3450.50,
      color: AppColors.cardPink,
    ),
    BankCard(
      id: 'c3',
      type: 'VISA',
      lastFour: '1120',
      balance: 850.00,
      color: AppColors.cardYellow,
    ),
  ];

  static final List<Transaction> recentTransactions = [
    Transaction(
      id: 't1',
      merchant: 'Spotify',
      category: 'Subscription',
      amount: 12.99,
      date: 'Today',
      isIncome: false,
      imageUrl: 'https://images.unsplash.com/photo-1614680376573-df3480f0c6ff?auto=format&fit=crop&w=100&q=80',
    ),
    Transaction(
      id: 't2',
      merchant: 'Upwork',
      category: 'Freelance',
      amount: 2450.00,
      date: 'Yesterday',
      isIncome: true,
      imageUrl: 'https://images.unsplash.com/photo-1573804633927-bfcbcd909acd?auto=format&fit=crop&w=100&q=80',
    ),
    Transaction(
      id: 't3',
      merchant: 'Netflix',
      category: 'Subscription',
      amount: 15.99,
      date: 'Oct 14',
      isIncome: false,
      imageUrl: 'https://images.unsplash.com/photo-1522869635100-9f4c5e86aa37?auto=format&fit=crop&w=100&q=80',
    ),
    Transaction(
      id: 't4',
      merchant: 'Whole Foods',
      category: 'Groceries',
      amount: 145.20,
      date: 'Oct 12',
      isIncome: false,
      imageUrl: 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=100&q=80',
    ),
  ];
}
