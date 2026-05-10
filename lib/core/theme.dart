import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // 💜 Base
  static const Color background = Color(0xFFFFADA5);
  static const Color backgroundSoft = Color(0xFFF2DFBB);

  // 🍰 UI
  static const Color surface = Color(0xFFFFF7E7);
  static const Color primaryColor = Color(0xFF301659); // Dark Purple

  // 🌾 Accent
  static const Color accent = Color(0xFFF2DA91);

  // 💜 Secondary (лаванда)
  static const Color secondary = Color(0xFFB7A3BF);

  // 📝 Text
  static const Color textPrimary = Color(0xFF301659);
  static const Color textSecondary = Color(0xFF7A5C4D);

  static const Color cardColor = Color(0xFFFFF4EE);
}

class AppTheme {
  static ThemeData get lightTheme {
    final base = ThemeData(
      fontFamily: GoogleFonts.pangolin().fontFamily,
      brightness: Brightness.light,
      useMaterial3: true,
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,

      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primaryColor,
        onPrimary: Colors.white,
        secondary: AppColors.secondary,
        onSecondary: Colors.white,
        error: AppColors.primaryColor,
        onError: Colors.white,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.secondary, // 💜 лаванда
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),

      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 6,
        shadowColor: Colors.black.withAlpha(150),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor, // 🍓
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.backgroundSoft,
          side: BorderSide(color: AppColors.backgroundSoft),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.backgroundSoft),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.accent, // 🌾
        foregroundColor: AppColors.textPrimary,
      ),

      iconTheme: IconThemeData(color: AppColors.textPrimary),

      textTheme: TextTheme(
        headlineLarge: GoogleFonts.pangolin().copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),
        headlineMedium: GoogleFonts.pangolin().copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 28,
        ),
        headlineSmall: GoogleFonts.pangolin().copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),

        displayLarge: GoogleFonts.pangolin().copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: GoogleFonts.pangolin().copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: GoogleFonts.pangolin().copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),

        titleLarge: GoogleFonts.rubik().copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 22,
        ),
        titleMedium: GoogleFonts.rubik().copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        titleSmall: GoogleFonts.rubik().copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),

        bodyLarge: GoogleFonts.rubik().copyWith(
          color: AppColors.textPrimary,
          fontSize: 16,
        ),
        bodyMedium: GoogleFonts.rubik().copyWith(
          color: AppColors.textSecondary,
          fontSize: 14,
        ),
        bodySmall: GoogleFonts.rubik().copyWith(
          color: AppColors.textSecondary,
          fontSize: 12,
        ),

        labelLarge: GoogleFonts.rubik().copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
        labelMedium: GoogleFonts.rubik().copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
        labelSmall: GoogleFonts.rubik().copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w400,
          fontSize: 11,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withAlpha(170),
        hintStyle: TextStyle(color: AppColors.textSecondary),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    final base = ThemeData(
      fontFamily: GoogleFonts.pangolin().fontFamily,
      brightness: Brightness.dark,
      useMaterial3: true,
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.primaryColor, // 💜 основной фон

      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.accent, // 🌾 мягкий акцент вместо темного
        onPrimary: AppColors.textPrimary,
        secondary: AppColors.secondary,
        onSecondary: Colors.white,
        error: Colors.redAccent,
        onError: Colors.white,
        surface: Color(0xFF3E2A6B), // чуть светлее фона для карточек
        onSurface: Colors.white,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),

      cardTheme: CardThemeData(
        color: Color(0xFF3E2A6B), // 💜 карточки светлее фона
        elevation: 6,
        shadowColor: Colors.black.withAlpha(200),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent, // 🌾 кнопки светлые
          foregroundColor: AppColors.textPrimary,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.accent,
          side: BorderSide(color: AppColors.accent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.accent),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.textPrimary,
      ),

      iconTheme: IconThemeData(color: Colors.white),

      textTheme: TextTheme(
        headlineLarge: GoogleFonts.pangolin(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: GoogleFonts.pangolin(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: GoogleFonts.pangolin(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),

        titleLarge: GoogleFonts.pangolin(color: Colors.white),
        titleMedium: GoogleFonts.pangolin(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: GoogleFonts.pangolin(
          color: Colors.white,
          letterSpacing: 0.1,
        ),

        bodyLarge: GoogleFonts.rubik(color: Colors.white),
        bodyMedium: GoogleFonts.rubik(color: Colors.white70),
        bodySmall: GoogleFonts.rubik(color: Colors.white60),

        labelLarge: GoogleFonts.rubik(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
        labelMedium: GoogleFonts.rubik(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
        labelSmall: GoogleFonts.rubik(
          color: Colors.white54,
          fontWeight: FontWeight.w400,
          fontSize: 11,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withAlpha(20), 
        hintStyle: TextStyle(color: Colors.white54),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
