import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../data/wallet_mock_data.dart';
import 'onboarding_screen.dart';
import 'profile_actions.dart';
import '../widgets/wallet_widgets.dart'; // FadeInSlide

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  bool _isDarkMode = true;
  bool _notificationsEnabled = true;

  late AnimationController _bannerController;
  late Animation<double> _bannerGlow;
  
  // Interactive Hover/Tap tracking for the invite banner
  bool _isBannerHovered = false;

  @override
  void initState() {
    super.initState();
    _bannerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    
    _bannerGlow = Tween<double>(begin: 0.1, end: 0.6).animate(
      CurvedAnimation(parent: _bannerController, curve: Curves.easeInOut)
    );
  }

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = WalletMockData.user;
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 600;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: isWide ? screenWidth * 0.15 : 24.0, // Tighter constraints for wide screens to match screenshot proportions
            vertical: 24.0,
          ),
          child: Column(
            children: [
              // Header Section
              const SizedBox(height: 20),
              FadeInSlide(
                delayMs: 0,
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primaryNeon, width: 2),
                        ),
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: AppColors.surface,
                          backgroundImage: NetworkImage(user.avatarUrl),
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Opening Image Picker...'), backgroundColor: AppColors.surfaceLight),
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primaryNeon,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryNeon.withOpacity(0.4),
                                  blurRadius: 8,
                                )
                              ]
                            ),
                            child: const Icon(Icons.edit, color: Colors.black, size: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FadeInSlide(
                delayMs: 100,
                child: Text(
                  user.name,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              FadeInSlide(
                delayMs: 150,
                child: const Text(
                  '@sophie_laurent',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Animated Invite Banner (Matches Screenshot perfectly)
              FadeInSlide(
                delayMs: 250,
                child: MouseRegion(
                  onEnter: (_) => setState(() => _isBannerHovered = true),
                  onExit: (_) => setState(() => _isBannerHovered = false),
                  child: GestureDetector(
                    onTapDown: (_) => setState(() => _isBannerHovered = true),
                    onTapUp: (_) => setState(() => _isBannerHovered = false),
                    onTapCancel: () => setState(() => _isBannerHovered = false),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const InviteFriendsScreen()));
                    },
                    child: AnimatedBuilder(
                      animation: _bannerGlow,
                      builder: (context, child) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
                          transform: Matrix4.translationValues(0, _isBannerHovered ? -4 : 0, 0), // Lifts up when hovered/tapped
                          decoration: BoxDecoration(
                            color: AppColors.primaryNeon,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryNeon.withOpacity(_isBannerHovered ? 0.8 : _bannerGlow.value),
                                blurRadius: _isBannerHovered ? 50 : 30,
                                spreadRadius: _isBannerHovered ? 5 : 2,
                                offset: const Offset(0, 10),
                              )
                            ],
                          ),
                          child: child,
                        );
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Invite friends',
                                  style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w900),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Get \$50 for every friend who joins and adds \$10.',
                                  style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                              boxShadow: _isBannerHovered ? [
                                BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))
                              ] : [],
                            ),
                            child: AnimatedRotation(
                              turns: _isBannerHovered ? -0.05 : 0, // Slight tilt on hover
                              duration: const Duration(milliseconds: 200),
                              child: const Icon(Icons.arrow_forward, color: AppColors.primaryNeon, size: 24),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48),

              // Settings Groups 
              FadeInSlide(
                delayMs: 350,
                child: _buildSettingsGroup(
                  title: 'Account',
                  children: [
                    _buildSettingsTile(
                      context, 
                      Icons.person_outline, 
                      'Personal Information',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PersonalInfoScreen())),
                    ),
                    const Divider(color: AppColors.surfaceLight, height: 1, indent: 70, endIndent: 24),
                    _buildSettingsTile(
                      context, 
                      Icons.account_balance_wallet_outlined, 
                      'Payment Methods',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentMethodsScreen())),
                    ),
                    const Divider(color: AppColors.surfaceLight, height: 1, indent: 70, endIndent: 24),
                    _buildSettingsTile(
                      context, 
                      Icons.security, 
                      'Security & Privacy',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SecurityScreen())),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              FadeInSlide(
                delayMs: 450,
                child: _buildSettingsGroup(
                  title: 'General',
                  children: [
                    _buildSettingsTile(
                      context, 
                      Icons.notifications_outlined, 
                      'Notifications',
                      isSwitch: true,
                      switchValue: _notificationsEnabled,
                      onSwitchChanged: (val) {
                        setState(() {
                          _notificationsEnabled = val;
                        });
                      }
                    ),
                    const Divider(color: AppColors.surfaceLight, height: 1, indent: 70, endIndent: 24),
                    _buildSettingsTile(
                      context, 
                      Icons.language, 
                      'Language', 
                      trailingText: 'English',
                      onTap: () {
                        _showLanguageBottomSheet(context);
                      }
                    ),
                    const Divider(color: AppColors.surfaceLight, height: 1, indent: 70, endIndent: 24),
                    _buildSettingsTile(
                      context, 
                      Icons.dark_mode_outlined, 
                      'Dark Mode', 
                      isSwitch: true,
                      switchValue: _isDarkMode,
                      onSwitchChanged: (val) {
                        setState(() {
                          _isDarkMode = val;
                        });
                      }
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              FadeInSlide(
                delayMs: 550,
                child: _buildSettingsGroup(
                  title: 'Support',
                  children: [
                    _buildSettingsTile(
                      context, 
                      Icons.help_outline, 
                      'Help Center',
                      onTap: () {
                         ScaffoldMessenger.of(context).showSnackBar(
                           const SnackBar(content: Text('Opening Support Portal...'), backgroundColor: AppColors.surfaceLight)
                         );
                      }
                    ),
                    const Divider(color: AppColors.surfaceLight, height: 1, indent: 70, endIndent: 24),
                    _buildSettingsTile(
                      context, 
                      Icons.info_outline, 
                      'Terms & Policies',
                      onTap: () {
                         ScaffoldMessenger.of(context).showSnackBar(
                           const SnackBar(content: Text('Viewing Policies...'), backgroundColor: AppColors.surfaceLight)
                         );
                      }
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),

              // Logout Button
              FadeInSlide(
                delayMs: 650,
                child: GestureDetector(
                  onTap: () {
                    _showLogoutConfirmationDialog(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.redAccent.withOpacity(0.3), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.redAccent.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 5),
                        )
                      ]
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout, color: Colors.redAccent, size: 24),
                        SizedBox(width: 12),
                        Text(
                          'Log Out',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 100), // Space for floating bottom nav
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsGroup({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 16),
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(28), // Larger radius matching screenshot
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 15,
                offset: const Offset(0, 5),
              )
            ]
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  // --- Dynamic Hover/Tap Tile ---
  Widget _buildSettingsTile(
    BuildContext context, 
    IconData icon, 
    String title, 
    {String? trailingText, 
    bool isSwitch = false,
    bool switchValue = false,
    ValueChanged<bool>? onSwitchChanged,
    VoidCallback? onTap}
  ) {
    return StatefulBuilder(
      builder: (context, setStateTile) {
        bool isHovered = false;
        
        return MouseRegion(
          onEnter: (_) => setStateTile(() => isHovered = true),
          onExit: (_) => setStateTile(() => isHovered = false),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: isSwitch ? () => onSwitchChanged?.call(!switchValue) : onTap,
              onHover: (hover) => setStateTile(() => isHovered = hover),
              borderRadius: BorderRadius.circular(28),
              highlightColor: AppColors.primaryNeon.withOpacity(0.05),
              splashColor: AppColors.primaryNeon.withOpacity(0.1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                decoration: BoxDecoration(
                  color: isHovered ? AppColors.surfaceLight.withOpacity(0.5) : Colors.transparent,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isHovered ? AppColors.primaryNeon.withOpacity(0.2) : AppColors.surfaceLight,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icon, 
                        color: isHovered ? AppColors.primaryNeon : AppColors.textSecondary, 
                        size: 24
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(
                          color: isHovered ? AppColors.primaryNeon : AppColors.textPrimary,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                        child: Text(title),
                      ),
                    ),
                    if (trailingText != null)
                      Text(
                        trailingText,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    if (isSwitch)
                      Transform.scale(
                        scale: 1.1, // Slightly larger switch matching screenshot
                        child: Switch(
                          value: switchValue,
                          onChanged: onSwitchChanged,
                          activeColor: AppColors.primaryNeon,
                          activeTrackColor: AppColors.primaryNeon.withOpacity(0.4),
                          inactiveThumbColor: AppColors.textSecondary,
                          inactiveTrackColor: AppColors.background,
                        ),
                      )
                    else if (trailingText == null)
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        transform: Matrix4.translationValues(isHovered ? 4 : 0, 0, 0),
                        child: Icon(
                          Icons.chevron_right, 
                          color: isHovered ? AppColors.primaryNeon : AppColors.textSecondary,
                          size: 24,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(32),
          height: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Select Language', style: TextStyle(color: AppColors.textPrimary, fontSize: 26, fontWeight: FontWeight.w900)),
              const SizedBox(height: 24),
              _buildLanguageOption('English (US)', true),
              _buildLanguageOption('Spanish (ES)', false),
              _buildLanguageOption('French (FR)', false),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(String title, bool isSelected) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      title: Text(
        title, 
        style: TextStyle(
          color: isSelected ? AppColors.primaryNeon : AppColors.textPrimary,
          fontSize: 18,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        )
      ),
      trailing: isSelected ? const Icon(Icons.check_circle, color: AppColors.primaryNeon, size: 28) : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onTap: () => Navigator.pop(context),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Log Out?', style: TextStyle(color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.bold)),
        content: const Text('Are you sure you want to log out of your secure wallet?', style: TextStyle(color: AppColors.textSecondary, fontSize: 16)),
        actionsPadding: const EdgeInsets.all(16),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary, fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); 
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const OnboardingScreen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                )
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent.withOpacity(0.2),
              foregroundColor: Colors.redAccent,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Log Out', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
