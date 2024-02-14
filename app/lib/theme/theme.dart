import 'package:flutter/material.dart';

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.green,
    brightness: Brightness.dark,
    shadow: const Color(0x7F000000),
    background: const Color(0xFF212832),
  ),
  primaryColor: Colors.white,
  primarySwatch: Colors.green,
  scaffoldBackgroundColor: const Color(0xFF212832),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Color(0xFBEFF2DB)),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF212832),
    titleTextStyle: TextStyle(
      color: Colors.green,
    ),
  ),
);
