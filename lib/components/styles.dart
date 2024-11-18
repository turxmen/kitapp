import 'package:flutter/material.dart';

// Define your theme data as a regular class
class AppTheme {
  static BottomNavigationBarThemeData bottomNavigationBarTheme =
      BottomNavigationBarThemeData(
    selectedItemColor: const Color(0xCCFFC107),
    unselectedItemColor: Colors.grey[400]!.withOpacity(0.7),
    selectedLabelStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    ),
    unselectedLabelStyle: const TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 12,
    ),
    elevation: 0,
    backgroundColor: Colors.white.withOpacity(0.8),
  );

  static AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: Colors.white.withOpacity(0.8),
    foregroundColor: Colors.black,
    elevation: 0,
    titleTextStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    centerTitle: true,
  );

  static BoxDecoration cardDecoration(Color shadowColor) {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.8),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: shadowColor.withOpacity(0.3),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: shadowColor.withOpacity(0.2),
          blurRadius: 8.0,
          spreadRadius: 3.0,
          offset: const Offset(-3.0, 3.0),
        ),
      ],
    );
  }

  static const Color appBackgroundColor = Colors.white;

  static ButtonStyle categoryButtonStyle(bool isSelected) {
    return ElevatedButton.styleFrom(
      backgroundColor: isSelected
          ? const Color(0xCCFFC107)
          : Colors.grey[300]!.withOpacity(0.5),
      foregroundColor: isSelected ? Colors.white : Colors.black,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }
}
/*
1. Core Colors:

Primary: #007bff (A vibrant blue, evoking freshness and trustworthiness)
Secondary: #ffc107 (A warm yellow, associated with food and energy)
Accent: #28a745 (A natural green, symbolizing health and growth)
2. Application:

Background: #f8f9fa (A light, neutral gray for a clean and spacious feel)
Buttons:
Primary buttons: #007bff (Blue, for main actions like "Add to Inventory")
Secondary buttons: #ffc107 (Yellow, for less prominent actions)
Accent buttons: #28a745 (Green, for positive actions like "Save Recipe")
Text:
Primary text: #212529 (Dark gray, for readability on the light background)
Secondary text: #6c757d (A lighter gray, for less important information)
Links: #007bff (Blue, to stand out and indicate interactivity)
Icons: Mostly white or #212529 (Dark gray), depending on the background
3. UI Elements:

Navigation bar: #ffffff (White background with #212529 icons)
Cards: #ffffff (White background with subtle shadows for depth)
Input fields: #ffffff (White background with #ced4da borders)
4. Visual Hierarchy:

Use color to guide the user's eye. The primary blue should be used for the most important actions or information.
Maintain good contrast between text and background for readability.
5. Accessibility:

Ensure sufficient color contrast for users with visual impairments. Test the colors with accessibility tools to meet WCAG guidelines.
6. Branding:

These colors can be incorporated into the app's logo and marketing materials for consistency.
*/