import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'CustomColorScheme.dart';

final theme = ThemeData.from(colorScheme: customColorScheme).copyWith(
  useMaterial3: true,
  scaffoldBackgroundColor: customColorScheme.surface,
  colorScheme: customColorScheme,
  visualDensity: VisualDensity.adaptivePlatformDensity,

  textTheme: GoogleFonts.openSansTextTheme().copyWith(
    titleSmall: GoogleFonts.openSans(
      fontWeight: FontWeight.w300,
      fontSize: 14.0,
    ),
    titleMedium: GoogleFonts.openSans(
      fontWeight: FontWeight.w400,
      fontSize: 16.0,
      color: customColorScheme.onSurface,
    ),
    titleLarge: GoogleFonts.openSans(
      fontWeight: FontWeight.w700,
      fontSize: 16.0,
      color: customColorScheme.onPrimaryContainer,
    ),
    bodySmall: GoogleFonts.openSans(
      fontWeight: FontWeight.w300,
      fontSize: 12.0,
      color: customColorScheme.onBackground.withOpacity(0.7),
    ),
    bodyMedium: GoogleFonts.openSans(
      fontWeight: FontWeight.w400,
      fontSize: 11.0,
      color: customColorScheme.tertiary,
    ),
    bodyLarge: GoogleFonts.openSans(
      fontWeight: FontWeight.w600,
      fontSize: 16.0,
      color: customColorScheme.tertiaryFixed,
    ),
  ),
);
