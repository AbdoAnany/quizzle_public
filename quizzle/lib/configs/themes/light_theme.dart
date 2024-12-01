import 'package:flutter/material.dart';
import 'sub_theme_data_mixin.dart';

// Updated Color Scheme
//  const Color kPrimaryLightColorLT = Color(0xFFFFC107); // Soft Yellow-Orange for accents
const Color kPrimaryLightColorLT = Color(0xff13b8f8); // Soft Yellow-Orange for accents
// const Color kPrimaryColorLT = Color(0xFFFF9800); // Bright Orange for primary color
const Color kPrimaryColorLT = Color(0xFF288fb8); // Bright Orange for primary color
const Color appBarIconColorLT = Colors.white;
const Color mainTextColorLT = Color(0xFF333333); // Dark gray for text readability
const Color iconColorLT = Colors.white;
const Color shadowColorLT = Color.fromARGB(90, 200, 200, 200);
// const Color cardColorLT = Color(0xFFFFF3E0); // Light Orange-Tinted Background for cards
const Color cardColorLT = Color(0xffe3f2f6); // Light Orange-Tinted Background for cards
const Color scaffoldBackgroundColorLT = Color(0xFFFFFfff); // Light Cream Background
// const Color scaffoldBackgroundColorLT = Color(0xFFFFF8E1); // Light Cream Background

// Additional Colors
const Color successColorLT = Color(0xFF4CAF50); // Green for success states
const Color warningColorLT = Color(0xFFFFC107); // Yellow for warnings or highlights
const Color errorColorLT = Color(0xFFF44336); // Red for errors or alerts

class LightTheme with SubThemeData {
  ThemeData buildLightTheme() {
    final ThemeData systemLightTheme = ThemeData.light();
    return systemLightTheme.copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: scaffoldBackgroundColorLT,
        iconTheme: getIconTheme(),
        splashColor: kPrimaryColorLT.withOpacity(0.1),
        highlightColor: kPrimaryColorLT.withOpacity(0.05),
        splashFactory: InkRipple.splashFactory,
        textTheme: getTextThemes().apply(bodyColor: mainTextColorLT, displayColor: mainTextColorLT),
        primaryColor: kPrimaryColorLT,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: getElavatedButtonTheme()),
        cardColor: cardColorLT,
        colorScheme: ColorScheme.fromSwatch(
            accentColor: kPrimaryColorLT, primarySwatch: Colors.purple));
  }
}
