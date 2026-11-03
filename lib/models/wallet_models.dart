import 'package:flutter/material.dart';

class UserProfile {
  final String name;
  final String avatarUrl;

  UserProfile({required this.name, required this.avatarUrl});
}

class BankCard {
  final String id;
  final String type; // e.g., VISA, Mastercard
  final String lastFour;
  final double balance;
  final Color color;

  BankCard({
    required this.id,
    required this.type,
    required this.lastFour,
    required this.balance,
    required this.color,
  });
}

class Transaction {
  final String id;
  final String merchant;
  final String category;
  final double amount;
  final String date;
  final bool isIncome;
  final String imageUrl;

  Transaction({
    required this.id,
    required this.merchant,
    required this.category,
    required this.amount,
    required this.date,
    required this.isIncome,
    required this.imageUrl,
  });
}
