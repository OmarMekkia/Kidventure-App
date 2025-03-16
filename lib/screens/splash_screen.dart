import 'package:flutter/material.dart';
import 'package:kidventure/data/splash_screen_contents.dart';
import 'package:kidventure/screens/home_screen.dart';
import 'package:kidventure/widgets/indicator_dots.dart';
import 'package:kidventure/widgets/splash_slide.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController pageController = PageController();
  int currentPage = 0;

  void goToNextPage() {
    if (currentPage == splashScreenContents.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F5),
      body: Stack(
        children: [
          PageView.builder(
            itemBuilder:
                (context, index) => SplashSlide(
                  splashScreenContent: splashScreenContents[index],
                  isActive: index == currentPage,
                ),
            itemCount: splashScreenContents.length,
            controller: pageController,
            onPageChanged: (index) => setState(() => currentPage = index),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              spacing: 24,
              children: [
                IndicatorDots(
                  count: splashScreenContents.length,
                  currentIndex: currentPage,
                  onDotPressed:
                      (index) => pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6B6B),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    elevation: 4,
                  ),
                  onPressed: goToNextPage,
                  child: Row(
                    spacing: 8,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        currentPage == splashScreenContents.length - 1
                            ? "Get Started"
                            : "Next",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Icon(Icons.arrow_forward, size: 18, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}