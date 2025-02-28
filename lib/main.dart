import 'package:flutter/material.dart';
import 'package:kidventure/pages/solar_system_screen.dart';

void main() {
  runApp(const SolarSystemApp());
}

class SolarSystemApp extends StatelessWidget {
  const SolarSystemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solar System Explorer',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1A1A2E),
      ),
      home: const SolarSystemScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}