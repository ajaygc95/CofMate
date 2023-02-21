import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    primaryColor: Color(0xFFF7786b),
    primaryColorDark: Color.fromARGB(255, 186, 53, 75),
    primaryColorLight: Color(0xFFFE9AAA),
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Color(0xFFF5f5f5),
    fontFamily: "Optima",
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Color(0xFF2B234A),
        fontWeight: FontWeight.bold,
        fontSize: 36,
      ),
      headline2: TextStyle(
        color: Color(0xFF2B234A),
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      headline3: TextStyle(
        color: Color(0xFF2B234A),
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      headline4: TextStyle(
        color: Color(0xFF2B234A),
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      headline5: TextStyle(
        color: Color(0xFF2B234A),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      headline6: TextStyle(
        color: Color(0xFF2B234A),
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
    ),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: Color(0xFFE84545)),
  );
}
