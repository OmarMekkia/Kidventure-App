import 'package:flutter/material.dart';
import 'package:kidventure/pages/splash_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash Screen',
      theme: ThemeData(
        primaryColor: const Color(0xFFFF6B6B),
        fontFamily: 'CrimsonText',
      ),
      home: const SplashScreen(),
    );
  }
}