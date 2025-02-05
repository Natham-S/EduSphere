import 'package:flutter/material.dart';

final customColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,

  seedColor: const Color.fromRGBO(118, 26, 255, 1.0),


  primary: const Color.fromRGBO(118, 26, 255, 1.0),
  onPrimary: Colors.white,
  primaryContainer: const Color.fromARGB(255, 176, 119, 255),
  onPrimaryContainer: const Color.fromARGB(255, 93, 15, 211),

  surface: const Color.fromARGB(255, 255, 255, 255),
  onSurface: const Color.fromARGB(255, 118, 26, 255),

  tertiary: const Color.fromARGB(255, 57, 57, 57),
  tertiaryFixed:  const Color.fromARGB(255, 30 , 30, 30),

  error: const Color(0xFFD32F2F),
  onError: Colors.white,
);
