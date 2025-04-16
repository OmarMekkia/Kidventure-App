import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:kidventure/screens/onboarding_screen.dart';
import 'package:kidventure/secrets.dart';

Future<void> main() async {
  // Ensure Flutter binding is initialized
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Keep the splash screen visible until app is fully loaded
  // This is crucial for native splash screen in release mode
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize Gemini API
  Gemini.init(apiKey: googleGeminiAPI, enableDebugging: true);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // Remove splash screen with a slight delay to ensure it's visible
    // This helps ensure the splash screen is shown in release mode
    Timer(const Duration(milliseconds: 800), () {
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kidventure',
      theme: ThemeData(fontFamily: 'CrimsonText'),
      home: const OnBoardingScreen(),
    );
  }
}
