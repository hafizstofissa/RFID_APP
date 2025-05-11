import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModernAppTheme {
  // الألوان الأساسية
  static const Color primaryColor = Color(0xFF6200EA); // بنفسجي
  static const Color accentColor = Color(0xFF03DAC5); // أخضر فاتح
  static const Color backgroundColor = Color(0xFFF1F3F4); // رمادي فاتح
  static const Color textColor = Color(0xFF202124); // أسود

  // الألوان للوضع الليلي
  static const Color darkPrimaryColor = Color(0xFFBB86FC); // بنفسجي فاتح
  static const Color darkBackgroundColor = Color(0xFF121212); // أسود
  static const Color darkTextColor = Color(0xFFE8EAED); // أبيض

  // الثيم الفاتح
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    hintColor: accentColor,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: AppBarTheme(
      color: primaryColor,
      elevation: 0,
      centerTitle: true,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.roboto(
        color: textColor,
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: GoogleFonts.roboto(
        color: textColor,
        fontSize: 16,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );

  // الثيم الداكن
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkPrimaryColor,
    hintColor: accentColor,
    scaffoldBackgroundColor: darkBackgroundColor,
    appBarTheme: AppBarTheme(
      color: darkPrimaryColor,
      elevation: 0,
      centerTitle: true,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.roboto(
        color: darkTextColor,
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: GoogleFonts.roboto(
        color: darkTextColor,
        fontSize: 16,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 3,
      color: Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );

  // دالة للتبديل بين الوضعين
  static ThemeMode getThemeMode(bool isDarkMode) {
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }
}
