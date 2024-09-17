import 'package:flutter/material.dart';

/*
 https://stackoverflow.com/questions/60232070/how-to-implement-dark-mode-and-light-mode-in-flutter
 I like having a theme option
*/
class MyAppThemes {
  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 183, 58, 89),
      brightness: Brightness.light,
    ),
    useMaterial3: true,
    brightness: Brightness.light,
  );

  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 183, 58, 89),
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    brightness: Brightness.dark,
  );
}