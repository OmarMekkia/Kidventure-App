import 'package:flutter/material.dart';
import 'package:kidventure/constants/app_colors.dart';
import 'package:kidventure/data/feature_card_contents.dart';
import 'package:kidventure/screens/premium_plan_screen.dart';
import 'package:kidventure/widgets/feature_card.dart';
import 'package:kidventure/widgets/home_app_bar.dart';
import 'package:kidventure/widgets/premium_plan_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String activeTab = "home";

  void setTab(String tab) {
    setState(() {
      activeTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use Directionality to support RTL for Arabic
    return Directionality(
      textDirection: TextDirection.rtl, // Set RTL direction for Arabic
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeAppBar(
                userName: "عمر حسام", // Arabic name
                userAvatar: "assets/images/user_avatar.png",
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    spacing: 18,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PremiumPlanCard(
                        onUpgrade:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => const PremiumPlansScreen(),
                              ),
                            ),
                      ),
                      ...featureCardContents.map(
                        (featureCardContent) =>
                            FeatureCard(featureCardContent: featureCardContent),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavigation(),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              "books",
              Icons.book,
              AppColors.booksTab,
              AppColors.booksTabBackground,
            ),
            _buildNavItem(
              "games",
              Icons.sports_esports,
              AppColors.gamesTab,
              AppColors.gamesTabBackground,
            ),
            _buildNavItem(
              "home",
              Icons.home,
              AppColors.homeTab,
              AppColors.homeTabBackground,
            ),
            _buildNavItem(
              "chat",
              Icons.chat_bubble,
              AppColors.chatTab,
              AppColors.chatTabBackground,
            ),
            _buildNavItem(
              "profile",
              Icons.person,
              AppColors.profileTab,
              AppColors.profileTabBackground,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    String tab,
    IconData icon,
    Color iconColor,
    Color activeColor,
  ) {
    final isActive = activeTab == tab;

    return GestureDetector(
      onTap: () => setTab(tab),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isActive ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(icon, color: iconColor, size: 28),
      ),
    );
  }
}
