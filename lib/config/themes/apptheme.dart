import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blue,
    hintColor: Colors.blueAccent,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Hind',
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 36, fontStyle: FontStyle.italic),
      bodyMedium: TextStyle(fontSize: 14, fontFamily: 'Hind'),
      bodySmall: TextStyle(fontSize: 20, fontFamily: 'Varela'),
    ),

    // Add more theme settings as needed
  );
}
