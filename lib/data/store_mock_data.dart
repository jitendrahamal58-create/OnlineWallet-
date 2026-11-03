import '../models/store_models.dart';
import '../core/theme/store_colors.dart';
import 'package:flutter/material.dart';

class StoreMockData {
  static final List<String> categories = [
    'All',
    'Cleansers',
    'Serums',
    'Sunscreen',
    'Creams',
    'Masks'
  ];

  static final List<StoreProduct> products = [
    StoreProduct(
      id: 'p1',
      name: 'Radiance Serum',
      price: 45.00,
      category: 'Serums',
      cardColor: StoreColors.primaryRed,
      isNew: true,
      imageUrl: 'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?auto=format&fit=crop&w=500&q=80',
    ),
    StoreProduct(
      id: 'p2',
      name: 'Daily Cleanser',
      price: 28.50,
      category: 'Cleansers',
      cardColor: StoreColors.primaryYellow,
      imageUrl: 'https://images.unsplash.com/photo-1556228578-0d85b1a4d571?auto=format&fit=crop&w=500&q=80',
    ),
    StoreProduct(
      id: 'p3',
      name: 'SPF 50 Sunscreen',
      price: 32.00,
      category: 'Sunscreen',
      cardColor: Colors.blueAccent.shade100,
      imageUrl: 'https://images.unsplash.com/photo-1570194065650-d99fb4b8ccb0?auto=format&fit=crop&w=500&q=80',
    ),
    StoreProduct(
      id: 'p4',
      name: 'Night Cream',
      price: 55.00,
      category: 'Creams',
      cardColor: Colors.teal.shade200,
      imageUrl: 'https://images.unsplash.com/photo-1608248543803-ba4f8c70ae0b?auto=format&fit=crop&w=500&q=80',
    ),
    StoreProduct(
      id: 'p5',
      name: 'Hydrating Mask',
      price: 22.00,
      category: 'Masks',
      cardColor: Colors.pink.shade200,
      imageUrl: 'https://images.unsplash.com/photo-1599305090598-fe179d501227?auto=format&fit=crop&w=500&q=80',
    ),
    StoreProduct(
      id: 'p6',
      name: 'Vitamin C Serum',
      price: 48.00,
      category: 'Serums',
      cardColor: Colors.orange.shade200,
      imageUrl: 'https://images.unsplash.com/photo-1629198688000-71f23e745b6e?auto=format&fit=crop&w=500&q=80',
    ),
    StoreProduct(
      id: 'p7',
      name: 'Gentle Cleanser',
      price: 26.00,
      category: 'Cleansers',
      cardColor: Colors.lightGreen.shade200,
      imageUrl: 'https://images.unsplash.com/photo-1617897903246-719242758050?auto=format&fit=crop&w=500&q=80',
    ),
    StoreProduct(
      id: 'p8',
      name: 'Eye Cream',
      price: 42.00,
      category: 'Creams',
      cardColor: Colors.purple.shade200,
      imageUrl: 'https://images.unsplash.com/photo-1556228720-192a6af4e86e?auto=format&fit=crop&w=500&q=80',
    ),
  ];

  static final List<StoreProduct> cartItems = [
    products[0],
    products[3],
  ];
}
