import 'package:flutter/material.dart';
import 'package:kidventure/constants/app_colors.dart';
import 'package:kidventure/widgets/premium_plan_card.dart';

class PremiumPlansScreen extends StatelessWidget {
  const PremiumPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Monthly Premium Plan',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),
              PremiumPlanCard(
                onUpgrade: () {
                  // Handle monthly plan upgrade
                },
              ),
              const SizedBox(height: 32),
              const Text(
                'Annual Premium Plan',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),
              PremiumPlanCard(
                price: '\$49.99',
                period: 'year',
                description: 'Save 17% with annual billing!',
                onUpgrade: () {
                  // Handle annual plan upgrade
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
