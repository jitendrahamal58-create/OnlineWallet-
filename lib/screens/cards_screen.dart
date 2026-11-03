import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../data/wallet_mock_data.dart';
import '../models/wallet_models.dart';
import 'wallet_actions.dart';
import '../widgets/wallet_widgets.dart'; // BouncyEntrance, TiltCard

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  late List<BankCard> _cards;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    _cards = List.from(WalletMockData.myCards);
  }

  void _addNewCard() {
    final newCard = BankCard(
      id: DateTime.now().toString(),
      type: 'Virtual Card',
      lastFour: '0000',
      balance: 0.00,
      color: Colors.cyanAccent, 
    );
    
    _cards.insert(0, newCard);
    
    _listKey.currentState?.insertItem(0, duration: const Duration(milliseconds: 600));
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Virtual Card Added Successfully!'),
        backgroundColor: AppColors.primaryNeon,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 600;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BouncyEntrance(
              delayMs: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? screenWidth * 0.1 : 24.0,
                  vertical: 24.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Wallets',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    BreathingWidget(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _addNewCard, 
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              color: AppColors.surface,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.add, color: AppColors.textPrimary),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            
            // Animated Horizontal Cards Scroll (Wrapped in TiltCard for 3D dragging)
            BouncyEntrance(
              delayMs: 200,
              child: SizedBox(
                height: 240,
                child: AnimatedList(
                  key: _listKey,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: isWide ? screenWidth * 0.1 : 24),
                  initialItemCount: _cards.length,
                  itemBuilder: (context, index, animation) {
                    return SlideTransition(
                      position: animation.drive(Tween(begin: const Offset(-1, 0), end: Offset.zero).chain(CurveTween(curve: Curves.elasticOut))), // Bouncy slide
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: TiltCard( // FUN 3D DRAG TILT
                          child: _buildBankCard(context, _cards[index])
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Stats / History Below Cards
            Expanded(
              child: FadeInSlide(
                delayMs: 400,
                slideOffset: const Offset(0, 0.4),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: isWide ? screenWidth * 0.1 : 24.0,
                    vertical: 32.0,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total wealth',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      // Animated Counter
                      TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0, end: 16532),
                        duration: const Duration(milliseconds: 2000),
                        curve: Curves.elasticOut,
                        builder: (context, value, child) {
                          return ShimmerText(
                            text: '\$${value.toStringAsFixed(0)}',
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 40,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -1,
                            ),
                          );
                        }
                      ),
                      const SizedBox(height: 40),
                      BouncyEntrance(delayMs: 600, child: _buildListTile(context, Icons.account_balance_wallet, 'Cash balance', '\$10,230.50')),
                      BouncyEntrance(delayMs: 700, child: _buildListTile(context, Icons.trending_up, 'Investments', '\$6,301.50')),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBankCard(BuildContext context, BankCard card) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => CardDetailsScreen(card: card)));
      },
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: card.color,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: card.color.withOpacity(0.3),
              blurRadius: 25,
              spreadRadius: 2,
              offset: const Offset(0, 12),
            ),
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    card.type,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.contactless, color: Colors.black87, size: 24),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '**** ${card.lastFour}',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '\$${card.balance.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context, IconData icon, String title, String amount) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const WealthBreakdownScreen()));
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryNeon.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.primaryNeon, size: 24),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                amount,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
