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
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1A1A2E),
        textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'CrimsonText'),
      ),
      home: const SplashScreen(),
    );
  }
}
