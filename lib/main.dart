import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:kidventure/screens/onboarding_screen.dart';
import 'package:kidventure/secrets.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Gemini.init(apiKey: googleGeminiAPI, enableDebugging: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
