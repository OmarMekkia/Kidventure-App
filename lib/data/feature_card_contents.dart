import 'package:flutter/material.dart';
import 'package:kidventure/models/feature_card_content.dart';
import 'package:kidventure/screens/solar_system_screen.dart';

final List<FeatureCardContent> featureCardContents = [
  FeatureCardContent(
    title: "رحلة عبر الفضاء",
    description:
        "انطلق إلى عجائب نظامنا الشمسي المذهلة! اكتشف الكواكب المدهشة وأقمارها الغامضة في مغامرة فضائية رائعة!",
    lottiePath: "assets/lotties/daily_space_card_lottie.json",
    buttonText: "ابدأ رحلتك الاستكشافية",
    onButtonPressed: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SolarSystemScreen()),
      );
    },
    gradientColors: [const Color(0xFFFF6B6B), const Color(0xFFFFB347)],
  ),
  FeatureCardContent(
    title: "اكتشف قوة مفرداتك",
    description:
        "اشحن عقلك بالطاقة! كل كلمة جديدة تتقنها هي خطوة نحو تواصل رائع وإمكانيات لا حدود لها!",
    lottiePath: "assets/lotties/flashcards_card_lottie.json",
    buttonText: "عزز قوة عقلك",
    onButtonPressed: (context) {},
    gradientColors: [const Color(0XFF6366F1), const Color(0XFF8B5CF6)],
  ),
  FeatureCardContent(
    title: "العب، تعلم، انمو!",
    description:
        "حول التعلم إلى مغامرات مثيرة! انغمس في ألعاب ممتعة تجعل كل كلمة ومفهوم جديد يثبت في ذهنك بينما تستمتع!",
    lottiePath: "assets/lotties/educational_games_card_lottie.json",
    buttonText: "ابدأ مغامرتك",
    onButtonPressed: (context) {},
    gradientColors: [const Color(0XFF10B981), const Color(0XFF3B82F6)],
  ),
  FeatureCardContent(
    title: "عوالم سحرية بانتظارك",
    description:
        "انطلق في رحلات مذهلة عبر قصص آسرة! اكتشف عوالم جديدة، وكوّن صداقات مع شخصيات رائعة، واجمع معرفة مدهشة على طول الطريق!",
    lottiePath: "assets/lotties/library_card_lottie.json",
    buttonText: "ابدأ رحلة قصتك",
    onButtonPressed: (context) {},
    gradientColors: [const Color(0XFF8B5CF6), const Color(0XFFEC4899)],
  ),
];
