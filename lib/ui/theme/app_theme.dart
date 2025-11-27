import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.deepPurple,
    scaffoldBackgroundColor: Colors.white,
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.grey[200],
      labelStyle: TextStyle(color: Colors.black),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.black87)
    )
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.deepPurple,
    scaffoldBackgroundColor: Colors.black,
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.black,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.grey[800],
      labelStyle: TextStyle(color: Colors.white70),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.white)
    )
  );
}