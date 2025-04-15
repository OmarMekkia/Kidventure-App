import 'package:flutter/material.dart';
import 'package:kidventure/constants/app_colors.dart';

class InteractiveStoriesScreen extends StatelessWidget {
  const InteractiveStoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text(
          "The interactive stories will be available soon!",
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
