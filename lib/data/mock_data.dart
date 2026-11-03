import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../core/theme/app_colors.dart';

class MockData {
  static final UserModel currentUser = UserModel(
    id: 'u1',
    name: 'Sophie Laurent',
    greeting: 'Good Morning',
    avatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=150&q=80',
    totalBalance: 33350.00,
  );

  static final List<TransactionModel> recentTransactions = [
    TransactionModel(
      id: 't1',
      title: 'Spotify Premium',
      subtitle: 'Subscription',
      amount: 12.99,
      isIncome: false,
      imageUrl: 'https://images.unsplash.com/photo-1614680376573-df3480f0c6ff?auto=format&fit=crop&w=100&q=80',
    ),
    TransactionModel(
      id: 't2',
      title: 'Dribbble LLC',
      subtitle: 'Pro Plan',
      amount: 25.00,
      isIncome: false,
      imageUrl: 'https://images.unsplash.com/photo-1611162617474-5b21e879e113?auto=format&fit=crop&w=100&q=80',
    ),
    TransactionModel(
      id: 't3',
      title: 'Upwork Escrow',
      subtitle: 'Freelance Income',
      amount: 4500.00,
      isIncome: true,
      fallbackIcon: Icons.work,
      iconColor: AppColors.primary,
    ),
    TransactionModel(
      id: 't4',
      title: 'Whole Foods Market',
      subtitle: 'Groceries',
      amount: 145.20,
      isIncome: false,
      imageUrl: 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=100&q=80',
    ),
  ];

  static final List<CategoryModel> categories = [
    CategoryModel(
      id: 'c1',
      name: 'Food & Dining',
      amount: 450.50,
      imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=300&q=80',
      icon: Icons.restaurant,
    ),
    CategoryModel(
      id: 'c2',
      name: 'Transportation',
      amount: 120.00,
      imageUrl: 'https://images.unsplash.com/photo-1449965408869-eaa3f722e40d?auto=format&fit=crop&w=300&q=80',
      icon: Icons.directions_car,
    ),
    CategoryModel(
      id: 'c3',
      name: 'Shopping',
      amount: 890.00,
      imageUrl: 'https://images.unsplash.com/photo-1483985988355-763728e1935b?auto=format&fit=crop&w=300&q=80',
      icon: Icons.shopping_bag,
    ),
    CategoryModel(
      id: 'c4',
      name: 'Entertainment',
      amount: 230.00,
      imageUrl: 'https://images.unsplash.com/photo-1470229722913-7c090be5c5a4?auto=format&fit=crop&w=300&q=80',
      icon: Icons.movie,
    ),
  ];
}
