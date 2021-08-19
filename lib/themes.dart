import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ColorScheme get lightColorScheme => ColorScheme.light(
      primary: const Color(0xFF658ABD),
      primaryVariant: const Color(0xff3700b3),
      secondary: const Color(0xFFF9C1B4),
      secondaryVariant: const Color(0xff018786),
      surface: Colors.white,
      background: Colors.white,
      error: const Color(0xffb00020),
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.black,
      onBackground: Colors.black,
      onError: Colors.white,
      brightness: Brightness.light,
    );

ColorScheme get darkColorScheme => ColorScheme.dark(
      primary: const Color(0xFF658ABD),
      primaryVariant: const Color(0xff3700B3),
      secondary: const Color(0xFFF9C1B4),
      secondaryVariant: const Color(0xff03dac6),
      surface: const Color(0xff121212),
      background: const Color(0xff121212),
      error: const Color(0xffcf6679),
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: Colors.white,
      onBackground: Colors.white,
      onError: Colors.black,
      brightness: Brightness.dark,
    );

TextTheme get textTheme => TextTheme(
      headline1: GoogleFonts.nanumGothic(
        fontSize: 93,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
      ),
      headline2: GoogleFonts.nanumGothic(
        fontSize: 58,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
      ),
      headline3: GoogleFonts.nanumGothic(
        fontSize: 47,
        fontWeight: FontWeight.w400,
      ),
      headline4: GoogleFonts.nanumGothic(
        fontSize: 33,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      headline5: GoogleFonts.nanumGothic(
        fontSize: 23,
        fontWeight: FontWeight.w400,
      ),
      headline6: GoogleFonts.nanumGothic(
        fontSize: 19,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      subtitle1: GoogleFonts.nanumGothic(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
      ),
      subtitle2: GoogleFonts.nanumGothic(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      bodyText1: GoogleFonts.nanumGothic(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodyText2: GoogleFonts.nanumGothic(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      button: GoogleFonts.nanumGothic(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
      ),
      caption: GoogleFonts.nanumGothic(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
      overline: GoogleFonts.nanumGothic(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
      ),
    );
