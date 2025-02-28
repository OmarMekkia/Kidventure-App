import 'package:flutter/material.dart';
import 'dart:math';

class StarryBackground extends StatefulWidget {
  const StarryBackground({super.key});

  @override
  State<StarryBackground> createState() => _StarryBackgroundState();
}

class Star {
  final Offset position;
  final double baseOpacity;
  final double speed;

  Star(this.position, this.baseOpacity, this.speed);
}

class _StarryBackgroundState extends State<StarryBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Star> _stars;
  // ignore: unused_field
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _stars = _generateStars();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _isDisposed = true;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            size: MediaQuery.of(context).size,
            painter: _StarPainter(stars: _stars, progress: _controller.value),
          );
        },
      ),
    );
  }

  static List<Star> _generateStars() {
    final random = Random();
    return List.generate(50, (_) {
      return Star(
        Offset(random.nextDouble() * 1000, random.nextDouble() * 1000),
        0.4 + random.nextDouble() * 0.6,
        0.3 + random.nextDouble() * 0.4,
      );
    });
  }
}

class _StarPainter extends CustomPainter {
  final List<Star> stars;
  final double progress;

  _StarPainter({required this.stars, required this.progress});
  @override
  void paint(Canvas canvas, Size size) {
    for (final star in stars) {
      final paint =
          Paint()
            ..color = Colors.white.withValues()
            ..style = PaintingStyle.fill;

      canvas.drawCircle(star.position, 1.5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StarPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
