import 'package:flutter/material.dart';
import 'package:kidventure/models/splash_screen_content.dart';
import 'package:lottie/lottie.dart';

class SplashSlide extends StatefulWidget {
  const SplashSlide({
    super.key,
    required this.splashScreenContent,
    required this.isActive,
  });

  final SplashScreenContent splashScreenContent;
  final bool isActive;

  @override
  State<SplashSlide> createState() => _SplashSlideState();
}

class _SplashSlideState extends State<SplashSlide>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> titleOffset;
  late Animation<Offset> descriptionOffset;
  late Animation<double> lottieOpacity;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    titleOffset = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );

    descriptionOffset = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
      ),
    );

    lottieOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    if (widget.isActive) {
      animationController.forward();
    }
  }

  @override
  void didUpdateWidget(covariant SplashSlide oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      animationController.forward(from: 0);
    } else if (!widget.isActive && oldWidget.isActive) {
      animationController.reverse();
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        spacing: 18,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeTransition(
            opacity: lottieOpacity,
            child: Lottie.asset(widget.splashScreenContent.lottiePath),
          ),
          SlideTransition(
            position: titleOffset,
            child: Text(
              widget.splashScreenContent.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF6B6B),
                height: 1.3,
              ),
            ),
          ),
          SlideTransition(
            position: descriptionOffset,
            child: Text(
              widget.splashScreenContent.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF666666),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
