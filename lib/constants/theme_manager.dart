import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  static final _textTheme = TextTheme(
    bodySmall: TextStyle(
      fontFamily: GoogleFonts.notoSerif().fontFamily,
    ),
    bodyMedium: TextStyle(
      fontFamily: GoogleFonts.notoSerif().fontFamily,
    ),
    bodyLarge: TextStyle(
      fontFamily: GoogleFonts.notoSerif().fontFamily,
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.w500,
      fontFamily: GoogleFonts.notoSerif().fontFamily,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontFamily: GoogleFonts.notoSerif().fontFamily,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: GoogleFonts.notoSerif().fontFamily,
    ),
    headlineSmall: TextStyle(
      fontWeight: FontWeight.w500,
      fontFamily: GoogleFonts.notoSerif().fontFamily,
    ),
    headlineMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontFamily: GoogleFonts.notoSerif().fontFamily,
    ),
    headlineLarge: TextStyle(
      fontWeight: FontWeight.w500,
      fontFamily: GoogleFonts.notoSerif().fontFamily,
    ),
    displaySmall: TextStyle(
      fontWeight: FontWeight.w500,
      fontFamily: GoogleFonts.notoSerif().fontFamily,
    ),
    displayMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontFamily: GoogleFonts.notoSerif().fontFamily,
    ),
    displayLarge: TextStyle(
      fontWeight: FontWeight.w500,
      fontFamily: GoogleFonts.notoSerif().fontFamily,
    ),
  );

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF121212),
      colorScheme: const ColorScheme.dark(
        surface: Colors.black,
        primary: Colors.white,
      ),
      textTheme: GoogleFonts.notoSerifTextTheme(_textTheme),
      dividerTheme: const DividerThemeData(thickness: .1),
      useMaterial3: true,
      bottomAppBarTheme: const BottomAppBarTheme(
        elevation: 0,
      ),
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.black,
        contentTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFamily: _textTheme.titleMedium!.fontFamily,
        ),
      ),
    );
  }

  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.grey.shade100,
      colorScheme: const ColorScheme.light(
        primary: Colors.black,
      ),
      textTheme: GoogleFonts.notoSerifTextTheme(_textTheme),
      dividerTheme: const DividerThemeData(thickness: .1),
      useMaterial3: true,
      bottomAppBarTheme: const BottomAppBarTheme(
        color: Colors.white,
        elevation: 0,
      ),
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.white,
        contentTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontFamily: _textTheme.titleMedium!.fontFamily,
        ),
      ),
    );
  }
}
