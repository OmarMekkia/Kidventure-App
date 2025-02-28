import 'package:flutter/material.dart';
import 'package:kidventure/models/celestial_body.dart';

final List<CelestialBody> celestialBodies = const [
  CelestialBody(
    id: "sun",
    name: "Sun",
    icon: "☀️",
    color: Color(0xFFFF6B6B),
    description: "The star at the center of our Solar System",
    modelId: 1,
    type: "star",
    order: 0,
    modelPath: "assets/models/sun.glb",
    information: '''Name: Sun
Size: 1.39 million km diameter (a star)
Color: Yellow-white (glowing plasma)
Description: Center of our Solar System
Unique Feature: Powers life on Earth through nuclear fusion''',
  ),
  CelestialBody(
    id: "mercury",
    name: "Mercury",
    icon: "☿",
    color: Color(0xFFA7A7A7),
    description: "The smallest and innermost planet",
    modelId: 2,
    type: "planet",
    order: 1,
    modelPath: "assets/models/mercury.glb",
    information: '''Name: Mercury
Size: 4,880 km diameter (smallest planet)
Color: Gray with a rocky, cratered surface
Description: Closest planet to the Sun
Unique Feature: Extreme temperature swings (-173°C to 427°C)''',
  ),
  CelestialBody(
    id: "venus",
    name: "Venus",
    icon: "♀",
    color: Color(0xFFE8B647),
    description: "The second planet from the Sun",
    modelId: 3,
    type: "planet",
    order: 2,
    modelPath: "assets/models/venus.glb",
    information: '''Name: Venus
Size: 12,104 km diameter (Earth's "twin")
Color: Yellowish-white with thick clouds
Description: Hottest planet (462°C average)
Unique Feature: Rotates backward (retrograde rotation)''',
  ),
  CelestialBody(
    id: "earth",
    name: "Earth",
    icon: "🌍",
    color: Color(0xFF4ECDC4),
    description: "Our home planet",
    modelId: 4,
    type: "planet",
    order: 3,
    modelPath: "assets/models/earth.glb",
    information: '''Name: Earth
Size: 12,742 km diameter
Color: Blue and green (water and land)
Description: Only planet with confirmed life
Unique Feature: 71% surface covered by water''',
  ),
  CelestialBody(
    id: "moon",
    name: "Moon",
    icon: "🌕",
    color: Color(0xFFD4D4D4),
    description: "Earth's natural satellite",
    modelId: 5,
    type: "moon",
    order: 4,
    modelPath: "assets/models/moon.glb",
    information: '''Name: Moon
Size: 3,474 km diameter (Earth's satellite)
Color: Gray with cratered surface
Description: Earth's natural companion
Unique Feature: Causes ocean tides on Earth''',
  ),
  CelestialBody(
    id: "mars",
    name: "Mars",
    icon: "♂",
    color: Color(0xFFFF4B4B),
    description: "The red planet",
    modelId: 6,
    type: "planet",
    order: 5,
    modelPath: "assets/models/mars.glb",
    information: '''Name: Mars
Size: 6,779 km diameter
Color: Red (iron oxide-rich soil)
Description: "Red Planet"
Unique Feature: Largest volcano in the solar system (Olympus Mons)''',
  ),
  CelestialBody(
    id: "jupiter",
    name: "Jupiter",
    icon: "♃",
    color: Color(0xFFE17055),
    description: "The largest planet in our Solar System",
    modelId: 7,
    type: "planet",
    order: 6,
    modelPath: "assets/models/jupiter.glb",
    information: '''Name: Jupiter
Size: 139,820 km diameter (largest planet)
Color: Orange and white bands
Description: Gas giant with Great Red Spot storm
Unique Feature: 95 known moons''',
  ),
  CelestialBody(
    id: "saturn",
    name: "Saturn",
    icon: "🪐",
    color: Color(0xFFFAD390),
    description: "The planet with spectacular rings",
    modelId: 8,
    type: "planet",
    order: 7,
    modelPath: "assets/models/saturn.glb",
    information: '''Name: Saturn
Size: 116,460 km diameter
Color: Pale gold with rings
Description: Famous for its icy rings
Unique Feature: Could float in water (low density)''',
  ),
  CelestialBody(
    id: "uranus",
    name: "Uranus",
    icon: "♅",
    color: Color(0xFF81ECEC),
    description: "The tilted ice giant",
    modelId: 9,
    type: "planet",
    order: 8,
    modelPath: "assets/models/uranus.glb",
    information: '''Name: Uranus
Size: 50,724 km diameter
Color: Pale blue-green (methane atmosphere)
Description: Ice giant tilted on its side
Unique Feature: -224°C coldest planet temperature''',
  ),
  CelestialBody(
    id: "neptune",
    name: "Neptune",
    icon: "♆",
    color: Color(0xFF4834D4),
    description: "The windiest planet",
    modelId: 10,
    type: "planet",
    order: 9,
    modelPath: "assets/models/neptune.glb",
    information: '''Name: Neptune
Size: 49,244 km diameter
Color: Deep azure blue
Description: Windiest planet (2,100 km/h winds)
Unique Feature: Farthest planet from the Sun''',
  ),
];
