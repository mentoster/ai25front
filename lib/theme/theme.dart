import 'package:ai25front/theme/colors.dart';
import 'package:flutter/material.dart';

final ThemeData mytheme = ThemeData(
  primaryColor: primary,
  hintColor: accent,
  scaffoldBackgroundColor: light,
  appBarTheme: const AppBarTheme(
    color: primary,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: accent,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: primary, // цвет текста
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: accent,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: primary),
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: accent),
      borderRadius: BorderRadius.circular(8),
    ),
    labelStyle: const TextStyle(color: dark),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: dark),
    titleLarge: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.bold, color: primary),
    bodyMedium: TextStyle(fontSize: 16.0, color: dark),
  ),
  sliderTheme: SliderThemeData(
    activeTrackColor: primary,
    inactiveTrackColor: dark,
    thumbColor: primary,
    overlayColor: primary.withOpacity(0.3),
  ),
  colorScheme: const ColorScheme.light(
    primary: primary,
    secondary: accent,
    onPrimary: Colors.white,
    surface: Colors.white,
  ).copyWith(),
);
