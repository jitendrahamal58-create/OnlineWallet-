import 'package:flutter/material.dart';

class UserModel {
  final String id;
  final String name;
  final String greeting;
  final String avatarUrl;
  final double totalBalance;

  UserModel({
    required this.id,
    required this.name,
    required this.greeting,
    required this.avatarUrl,
    required this.totalBalance,
  });
}

class TransactionModel {
  final String id;
  final String title;
  final String subtitle;
  final double amount;
  final bool isIncome;
  final String? imageUrl;
  final IconData? fallbackIcon;
  final Color? iconColor;

  TransactionModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isIncome,
    this.imageUrl,
    this.fallbackIcon,
    this.iconColor,
  });
}

class CategoryModel {
  final String id;
  final String name;
  final double amount;
  final String imageUrl;
  final IconData icon;

  CategoryModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.imageUrl,
    required this.icon,
  });
}
