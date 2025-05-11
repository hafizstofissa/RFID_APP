import 'package:flutter/material.dart';

class AlJazeeraColors {
  // الألوان الأساسية لموقع الجزيرة
  static const Color primaryDarkBlue = Color(0xFF1A4B84);   // الأزرق الداكن
  static const Color accentGold = Color(0xFFBFA054);        // اللون الذهبي
  static const Color backgroundWhite = Color(0xFFF5F5F5);  // الأبيض العاجي
  static const Color textBlack = Color(0xFF333333);        // أسود داكن للنصوص
  static const Color secondaryBlue = Color(0xFF2C6CB3);    // أزرق ثانوي

  // إنشاء نظام ألوان للتطبيق
  static ThemeData createTheme(BuildContext context) {
    return ThemeData(
      primaryColor: primaryDarkBlue,
      scaffoldBackgroundColor: backgroundWhite,
      
      // تنسيق شريط التطبيق
      appBarTheme: AppBarTheme(
        color: primaryDarkBlue,
        elevation: 4,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Cairo',
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      
      // تنسيق النصوص
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Cairo',
          color: textBlack,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Cairo',
          color: primaryDarkBlue,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Cairo',
          color: textBlack,
          fontSize: 16,
          height: 1.6, // تحسين المسافة بين الأسطر
        ),
      ),
      
      // تنسيق الأزرار
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryDarkBlue,
          foregroundColor: Colors.white,
          textStyle: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      
      // نظام الألوان
      colorScheme: ColorScheme.light(
        primary: primaryDarkBlue,
        secondary: accentGold,
        background: backgroundWhite,
        surface: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
      ),
    );
  }

  // دارك مود للتطبيق
  static ThemeData createDarkTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: secondaryBlue,
      scaffoldBackgroundColor: Color(0xFF121212),
      
      appBarTheme: AppBarTheme(
        color: secondaryBlue,
        elevation: 4,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Cairo',
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Cairo',
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Cairo',
          color: accentGold,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Cairo',
          color: Colors.white70,
          fontSize: 16,
          height: 1.6,
        ),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: secondaryBlue,
          foregroundColor: Colors.white,
          textStyle: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      
      colorScheme: ColorScheme.dark(
        primary: secondaryBlue,
        secondary: accentGold,
        background: Color(0xFF121212),
        surface: textBlack,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
      ),
    );
  }
}
