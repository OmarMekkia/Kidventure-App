import 'package:flutter/material.dart';
import 'package:kidventure/models/feature_card_content.dart';
import 'package:kidventure/screens/educational_games_screen.dart';
import 'package:kidventure/screens/flashcards_screen.dart';
import 'package:kidventure/screens/interactive_stories_screen.dart';
import 'package:kidventure/screens/solar_system_screen.dart';

final List<FeatureCardContent> featureCardContents = [
  FeatureCardContent(
    title: "Journey Through Space",
    description:
        "Blast off to the amazing wonders of our solar system! Discover awesome planets and their mysterious moons in an exciting space adventure!",
    lottiePath: "assets/lotties/daily_space_card_lottie.json",
    buttonText: "Start Your Exploration",
    onButtonPressed: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SolarSystemScreen()),
      );
    },
    gradientColors: [const Color(0xFFFF6B6B), const Color(0xFFFFB347)],
  ),
  FeatureCardContent(
    title: "Discover Your Word Power",
    description:
        "Power up your brain! Each new word you master is a step toward awesome communication and endless possibilities!",
    lottiePath: "assets/lotties/flashcards_card_lottie.json",
    buttonText: "Boost Your Brain Power",
    onButtonPressed: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FlashcardsScreen()),
      );
    },
    gradientColors: [const Color(0XFF6366F1), const Color(0XFF8B5CF6)],
  ),
  FeatureCardContent(
    title: "Play, Learn, Grow!",
    description:
        "Turn learning into exciting adventures! Dive into fun games that make every new word and idea stick in your mind while you have a blast!",
    lottiePath: "assets/lotties/educational_games_card_lottie.json",
    buttonText: "Start Your Adventure",
    onButtonPressed: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EducationalGamesScreen()),
      );
    },
    gradientColors: [const Color(0XFF10B981), const Color(0XFF3B82F6)],
  ),
  FeatureCardContent(
    title: "Magical Worlds Await You",
    description:
        "Embark on amazing journeys through captivating stories! Discover new worlds, make friends with wonderful characters, and gather incredible knowledge along the way!",
    lottiePath: "assets/lotties/library_card_lottie.json",
    buttonText: "Begin Your Story Journey",
    onButtonPressed: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const InteractiveStoriesScreen(),
        ),
      );
    },
    gradientColors: [const Color(0XFF8B5CF6), const Color(0XFFEC4899)],
  ),
];
