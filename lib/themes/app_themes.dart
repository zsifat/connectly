import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
      brightness: Brightness.light,
      textTheme: GoogleFonts.interTextTheme(),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),

      primaryTextTheme: TextTheme(
        bodyLarge: GoogleFonts.inter(
            color: Color(0xFF212936)
        ),
      ),

      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: Colors.white,
      ));

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        textTheme: GoogleFonts.interTextTheme(),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
      primaryTextTheme: TextTheme(
        bodyLarge: GoogleFonts.inter(
            color: const Color(0xFFE0E0E0)
        ),
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: Colors.black,
      )
      );
}
