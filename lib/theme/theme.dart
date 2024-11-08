import 'package:ai25front/theme/colors.dart';
import 'package:flutter/material.dart';

final ThemeData greenTheme = ThemeData(
  primaryColor: primaryGreen,
  hintColor: accentGreen,
  scaffoldBackgroundColor: lightGreen,
  appBarTheme: const AppBarTheme(
    color: primaryGreen,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: accentGreen,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: primaryGreen, // цвет текста
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: accentGreen,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: primaryGreen),
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: accentGreen),
      borderRadius: BorderRadius.circular(8),
    ),
    labelStyle: const TextStyle(color: darkGreen),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: darkGreen),
    titleLarge: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.bold, color: primaryGreen),
    bodyMedium: TextStyle(fontSize: 16.0, color: darkGreen),
  ),
  colorScheme: const ColorScheme.light(
    primary: primaryGreen,
    secondary: accentGreen,
    onPrimary: Colors.white,
    surface: Colors.white,
  ).copyWith(),
);
