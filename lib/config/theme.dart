import 'package:flutter/material.dart';

class AppTheme {
  // Colors from Figma design
  static const Color primaryGreen = Color(0xFF27AE60);
  static const Color yellowGenre = Color(0xFFF2C94C);
  static const Color orangeGenre = Color(0xFFF2994A);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color lightGrey = Color(0xFFF2F2F2);
  static const Color primaryText = Color(0xFF000000);
  static const Color secondaryText = Color(0xFF828282);
  
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: primaryGreen,
        secondary: yellowGenre,
        surface: backgroundColor,
        onPrimary: Colors.white,
        onSurface: primaryText,
      ),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryText),
        titleTextStyle: TextStyle(
          color: primaryText,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: backgroundColor,
        selectedItemColor: primaryGreen,
        unselectedItemColor: secondaryText,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: primaryText,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: primaryText,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: primaryText,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: primaryText,
        ),
        bodySmall: TextStyle(
          fontSize: 14,
          color: secondaryText,
        ),
      ),
    );
  }
}
