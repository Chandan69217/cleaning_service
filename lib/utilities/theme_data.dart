import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeData(){
  return ThemeData(
    useMaterial3: true,
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins().copyWith(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
      ),
            bodyMedium: GoogleFonts.poppins().copyWith(
          fontSize: 16.0,
        ),
        bodySmall: GoogleFonts.poppins().copyWith(
          fontSize: 13.0,
        )
    )
  );
}