import 'package:flutter/material.dart';

class StoreProduct {
  final String id;
  final String name;
  final double price;
  final String category;
  final Color cardColor;
  final String? imageUrl;
  final bool isNew;

  StoreProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.cardColor,
    this.imageUrl,
    this.isNew = false,
  });
}
