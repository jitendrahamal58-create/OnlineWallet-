import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../models/wallet_models.dart';

// --- CARD DETAILS SCREEN ---
class CardDetailsScreen extends StatefulWidget {
  final BankCard card;

  const CardDetailsScreen({super.key, required this.card});

  @override
  State<CardDetailsScreen> createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  bool _isFrozen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryNeon),
        title: Text('${widget.card.type} Details', style: const TextStyle(color: AppColors.textPrimary)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Big Card Display
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: _isFrozen ? Colors.grey.shade800 : widget.card.color,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  if (!_isFrozen)
                    BoxShadow(
                      color: widget.card.color.withOpacity(0.3),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.card.type,
                        style: TextStyle(
                          color: _isFrozen ? Colors.grey.shade400 : Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 24,
                        ),
                      ),
                      Icon(Icons.contactless, color: _isFrozen ? Colors.grey.shade500 : Colors.black87, size: 28),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text(
                    '**** **** **** ${widget.card.lastFour}',
                    style: TextStyle(
                      color: _isFrozen ? Colors.grey.shade400 : Colors.black87,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '\$${widget.card.balance.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: _isFrozen ? Colors.grey.shade500 : Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Controls
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Freeze Card', style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                      Switch(
                        value: _isFrozen,
                        onChanged: (val) {
                          setState(() {
                            _isFrozen = val;
                          });
                        },
                        activeColor: AppColors.primaryNeon,
                      ),
                    ],
                  ),
                  const Divider(color: AppColors.surfaceLight, height: 32),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Show PIN', style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                      Icon(Icons.visibility_outlined, color: AppColors.textSecondary),
                    ],
                  ),
                  const Divider(color: AppColors.surfaceLight, height: 32),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Card Limits', style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                      Icon(Icons.chevron_right, color: AppColors.textSecondary),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- WEALTH BREAKDOWN SCREEN ---
class WealthBreakdownScreen extends StatelessWidget {
  const WealthBreakdownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryNeon),
        title: const Text('Wealth Breakdown', style: TextStyle(color: AppColors.textPrimary)),
      ),
      body: const Center(
        child: Text('Detailed Wealth Charts & Info', style: TextStyle(color: AppColors.textPrimary, fontSize: 20)),
      ),
    );
  }
}

// --- CATEGORY DETAILS SCREEN ---
class CategoryDetailsScreen extends StatelessWidget {
  final String categoryTitle;
  final String amount;
  final IconData icon;

  const CategoryDetailsScreen({
    super.key,
    required this.categoryTitle,
    required this.amount,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryNeon),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primaryNeon, size: 48),
            ),
            const SizedBox(height: 24),
            Text(
              categoryTitle,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              amount,
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 48, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    'Transaction history for this category will appear here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
