import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import 'main_screen.dart';
import 'dart:ui';
import 'dart:math';
import '../widgets/wallet_widgets.dart'; // Implemented new fun animations here

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with TickerProviderStateMixin {
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;
  
  late AnimationController _spinController;

  @override
  void initState() {
    super.initState();
    // Up/down float
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true); 
    _floatAnimation = CurvedAnimation(parent: _floatController, curve: Curves.easeInOutSine);

    // Continuous slow 3D rotation
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15), // Slow majestic spin
    )..repeat();
  }

  @override
  void dispose() {
    _floatController.dispose();
    _spinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Animated Background glowing orb that moves slowly
          AnimatedBuilder(
            animation: _floatAnimation,
            builder: (context, child) {
              return Positioned(
                top: -100 + (30 * _floatAnimation.value), // Orb slowly moves too
                right: -100 + (20 * _floatAnimation.value),
                child: Container(
                  width: 450,
                  height: 450,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primaryNeon.withOpacity(0.3),
                        AppColors.background.withOpacity(0.0),
                      ],
                    ),
                  ),
                ),
              );
            }
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  BouncyEntrance(
                    delayMs: 100,
                    child: Row(
                      children: [
                        BreathingWidget(
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.primaryNeon,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.star_rounded, color: Colors.black),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'nova',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  
                  // Massive 3D Spinning & Floating Card
                  BouncyEntrance(
                    delayMs: 400,
                    child: Center(
                      child: AnimatedBuilder(
                        animation: Listenable.merge([_floatAnimation, _spinController]),
                        builder: (context, child) {
                          // Transform combines up/down translate + continuous Y-axis rotation
                          return Transform(
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001) // perspective
                              ..translate(0.0, -20 * _floatAnimation.value, 0.0) // Float
                              ..rotateY(_spinController.value * 2 * pi) // Continuous Spin
                              ..rotateX(0.1), // Slight fixed tilt
                            alignment: Alignment.center,
                            child: child,
                          );
                        },
                        child: Container(
                          width: 250,
                          height: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF2A2A2A), Color(0xFF121212)],
                            ),
                            border: Border.all(color: AppColors.primaryNeon.withOpacity(0.3)),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryNeon.withOpacity(0.2),
                                blurRadius: 40,
                                offset: const Offset(0, 20),
                              )
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: const Center(
                                child: Icon(Icons.credit_card_outlined, size: 80, color: AppColors.primaryNeon),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  const Spacer(),
                  BouncyEntrance(
                    delayMs: 600,
                    child: ShimmerText(
                      text: 'Open\nan account\nin 3 minutes',
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 42,
                        fontWeight: FontWeight.w900,
                        height: 1.1,
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FadeInSlide(
                    delayMs: 700,
                    child: const Text(
                      'No paperwork.\nJust your ID and a selfie.',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  BouncyEntrance(
                    delayMs: 800,
                    child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => const MainScreen(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation.drive(CurveTween(curve: Curves.easeInCubic)), 
                                  child: ScaleTransition(
                                    scale: animation.drive(Tween(begin: 1.2, end: 1.0).chain(CurveTween(curve: Curves.easeOutCubic))),
                                    child: child
                                  )
                                );
                              },
                              transitionDuration: const Duration(milliseconds: 800),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryNeon,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Go to app',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
