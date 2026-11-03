import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../data/wallet_mock_data.dart';
import '../widgets/wallet_widgets.dart'; // Using new fun widgets
import 'action_screens.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onProfileTap;

  const HomeScreen({super.key, required this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    final user = WalletMockData.user;
    final balance = WalletMockData.myCards.first.balance;
    final transactions = WalletMockData.recentTransactions;

    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 600;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()), // Extra bouncy scroll
          padding: EdgeInsets.symmetric(
            horizontal: isWide ? screenWidth * 0.1 : 24.0,
            vertical: 24.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              FadeInSlide(
                delayMs: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: onProfileTap,
                      child: Row(
                        children: [
                          // Fun Breathing Avatar
                          BreathingWidget(
                            child: CircleAvatar(
                              radius: 24,
                              backgroundColor: AppColors.surface,
                              backgroundImage: NetworkImage(user.avatarUrl),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Home',
                                style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                              ),
                              Text(
                                user.name,
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        _buildHeaderIcon(context, Icons.search, () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen()));
                        }),
                        const SizedBox(width: 12),
                        _buildHeaderIcon(context, Icons.notifications_none, () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()));
                        }),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              // Massive Neon Balance Card
              BouncyEntrance(
                delayMs: 150,
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Viewing Balance Details...'),
                        backgroundColor: AppColors.surfaceLight,
                        duration: Duration(seconds: 1),
                      )
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(isWide ? 48 : 32),
                    decoration: BoxDecoration(
                      color: AppColors.primaryNeon,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryNeon.withOpacity(0.3),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        )
                      ]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total balance',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Animated count up for balance WITH Shimmer effect!
                        TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0, end: balance),
                          duration: const Duration(milliseconds: 1800),
                          curve: Curves.elasticOut, // Extremely fun bouncy counter
                          builder: (context, value, child) {
                            return ShimmerText(
                              text: '\$${value.toStringAsFixed(0)}',
                              style: TextStyle(
                                color: Colors.black, // Dark shimmer base
                                fontSize: isWide ? 64 : 48,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -2,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Action Buttons
              BouncyEntrance(
                delayMs: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ActionPill(
                        icon: Icons.arrow_upward,
                        label: 'Send',
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const SendMoneyScreen()));
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ActionPill(
                        icon: Icons.arrow_downward,
                        label: 'Request',
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const RequestMoneyScreen()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              BouncyEntrance(
                delayMs: 450,
                child: const Text(
                  'Recent transactions',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Transactions List with Staggered Bounces
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return BouncyEntrance(
                    delayMs: 500 + (index * 150), // Staggered entry
                    child: TransactionTile(
                      transaction: transactions[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TransactionDetailScreen(transaction: transactions[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 40), 
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderIcon(BuildContext context, IconData icon, VoidCallback onTap) {
    return BreathingWidget(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.textPrimary, size: 20),
          ),
        ),
      ),
    );
  }
}
