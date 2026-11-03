import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import 'dart:math';
import 'wallet_actions.dart';
import '../widgets/wallet_widgets.dart'; // BouncyEntrance, ShimmerText

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String _selectedTimeFrame = 'This Month';
  List<double> _chartHeights = [];
  double _totalSpend = 0.0; 

  @override
  void initState() {
    super.initState();
    _generateRandomData(); 
  }

  void _generateRandomData() {
    final random = Random();
    setState(() {
      _chartHeights = List.generate(6, (index) => 20.0 + random.nextInt(80));
      if (_selectedTimeFrame == 'This Week') {
        _totalSpend = 142.50 + random.nextInt(100);
      } else if (_selectedTimeFrame == 'This Month') {
        _totalSpend = 400.00 + random.nextInt(300);
      } else {
        _totalSpend = 5000.00 + random.nextInt(2000);
      }
    });
  }

  void _showTimeFramePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(32),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Select Time Frame', style: TextStyle(color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              _buildTimeOption('This Week'),
              _buildTimeOption('This Month'),
              _buildTimeOption('This Year'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimeOption(String title) {
    final isSelected = _selectedTimeFrame == title;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppColors.primaryNeon : AppColors.textPrimary,
          fontSize: 18,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: isSelected ? const Icon(Icons.check_circle, color: AppColors.primaryNeon, size: 28) : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onTap: () {
        setState(() {
          _selectedTimeFrame = title;
        });
        _generateRandomData(); 
        Navigator.pop(context); 
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 600;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: EdgeInsets.symmetric(
            horizontal: isWide ? screenWidth * 0.1 : 24.0,
            vertical: 24.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BouncyEntrance(
                delayMs: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Analytics',
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
                          onTap: _showTimeFramePicker,
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Row(
                              children: [
                                Text(_selectedTimeFrame, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
                                const SizedBox(width: 8),
                                const Icon(Icons.keyboard_arrow_down, color: AppColors.textPrimary, size: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              // Dark Analytics Chart Card
              BouncyEntrance(
                delayMs: 200,
                child: Container(
                  width: double.infinity,
                  height: 340,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      )
                    ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total spend',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      // Animated Count up + Shimmer
                      TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0, end: _totalSpend),
                        duration: const Duration(milliseconds: 2000),
                        curve: Curves.elasticOut,
                        builder: (context, value, _) {
                          return ShimmerText(
                            text: '\$${value.toStringAsFixed(0)}',
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 48,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -1,
                            ),
                          );
                        }
                      ),
                      const Spacer(),
                      
                      // Animated Chart Columns
                      SizedBox(
                        height: 120,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(6, (index) {
                            final isToday = index == 4;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Glowing Chart Dot
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 700),
                                  curve: Curves.elasticOut,
                                  width: 12,
                                  height: 12,
                                  transform: Matrix4.translationValues(0, -(_chartHeights[index] / 10), 0), // Slight jump based on height
                                  decoration: BoxDecoration(
                                    color: isToday ? AppColors.primaryNeon : AppColors.textSecondary,
                                    shape: BoxShape.circle,
                                    boxShadow: isToday ? [
                                      BoxShadow(
                                        color: AppColors.primaryNeon.withOpacity(0.8),
                                        blurRadius: 15,
                                        spreadRadius: 3,
                                      )
                                    ] : null,
                                  ),
                                ),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 1000),
                                  curve: Curves.elasticOut,
                                  width: 4, // Thicker lines
                                  height: _chartHeights[index],
                                  decoration: BoxDecoration(
                                    color: isToday ? AppColors.primaryNeon.withOpacity(0.5) : AppColors.textSecondary.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  ['10', '15', '20', '25', '30', '04'][index],
                                  style: TextStyle(
                                    color: isToday ? AppColors.primaryNeon : AppColors.textSecondary,
                                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              
              BouncyEntrance(
                delayMs: 400,
                child: const Text(
                  'Top spending',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              BouncyEntrance(delayMs: 500, child: _buildSpendingTile(context, 'Food & Drink', '\$320.00', Icons.restaurant, 0.6)),
              BouncyEntrance(delayMs: 600, child: _buildSpendingTile(context, 'Transport', '\$105.00', Icons.directions_car, 0.3)),
              BouncyEntrance(delayMs: 700, child: _buildSpendingTile(context, 'Entertainment', '\$98.00', Icons.movie, 0.2)),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpendingTile(BuildContext context, String title, String amount, IconData icon, double progress) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
           Navigator.push(
             context,
             MaterialPageRoute(
               builder: (_) => CategoryDetailsScreen(
                 categoryTitle: title,
                 amount: amount,
                 icon: icon,
               ),
             ),
           );
        },
        borderRadius: BorderRadius.circular(24),
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: AppColors.surfaceLight,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: AppColors.textPrimary, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    amount,
                    style: const TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: progress),
                duration: const Duration(milliseconds: 2000),
                curve: Curves.elasticOut, // Extremely bouncy progress bars
                builder: (context, value, _) {
                  return LinearProgressIndicator(
                    value: value,
                    backgroundColor: AppColors.surfaceLight,
                    color: AppColors.primaryNeon,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(4),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
