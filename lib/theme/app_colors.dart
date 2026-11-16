import 'package:flutter/material.dart';

abstract final class AppColors {
  // Dark backgrounds
  static const darkBg1 = Color(0xFF080E1E);
  static const darkBg2 = Color(0xFF0D1A2F);
  static const darkBg3 = Color(0xFF0A1220);

  // Light backgrounds
  static const lightBg1 = Color(0xFFECF3FF);
  static const lightBg2 = Color(0xFFE6F4EF);
  static const lightBg3 = Color(0xFFEDF2FE);

  // Glass – dark
  static const darkGlass       = Color(0x14FFFFFF);
  static const darkGlassBorder = Color(0x26FFFFFF);

  // Glass – light
  static const lightGlass       = Color(0xBFFFFFFF);
  static const lightGlassBorder = Color(0x80FFFFFF);

  // Brand
  static const teal     = Color(0xFF4ECBA8);
  static const tealDark = Color(0xFF2D8F7B);
  static const blue     = Color(0xFF6B9AFF);
  static const blueDark = Color(0xFF4A70D9);
  static const gold     = Color(0xFFFFD43B);
  static const orange   = Color(0xFFFF9D23);
  static const error    = Color(0xFFFF6B6B);

  // Text – dark mode
  static const darkText    = Color(0xFFE8F0FF);
  static const darkSubtext = Color(0xFF8B9BB8);
  static const darkMuted   = Color(0xFF4A5568);

  // Text – light mode
  static const lightText    = Color(0xFF0D1B33);
  static const lightSubtext = Color(0xFF4A5568);
  static const lightMuted   = Color(0xFF8B9BB8);

  static const tealGradient = LinearGradient(
    colors: [Color(0xFF4ECBA8), Color(0xFF2D8F7B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const blueGradient = LinearGradient(
    colors: [Color(0xFF6B9AFF), Color(0xFF4A70D9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const goldGradient = LinearGradient(
    colors: [Color(0xFFFFD43B), Color(0xFFFF9D23)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const purpleGradient = LinearGradient(
    colors: [Color(0xFFDA77FF), Color(0xFF9B59B6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const darkBg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF080E1E), Color(0xFF0D1A2F), Color(0xFF0A1220)],
    stops: [0, .5, 1],
  );

  static const lightBg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFECF3FF), Color(0xFFE6F4EF), Color(0xFFEDF2FE)],
    stops: [0, .5, 1],
  );
}
