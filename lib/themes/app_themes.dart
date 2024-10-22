import 'package:flutter/material.dart';

/*
 https://stackoverflow.com/questions/60232070/how-to-implement-dark-mode-and-light-mode-in-flutter
 I like having a theme option
*/
class MyAppThemes {
  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Color.fromARGB(255, 221, 221, 221), // Soft blue
      onPrimary: Colors.black87,
      secondary: Color.fromARGB(255, 20, 21, 33), // Light purple
      onSecondary: Colors.white,
      surface: Color(0xFFF7F7F7), // Soft gray for background
      onSurface: Colors.black87,
    ),
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF7F7F7), // Soft light gray
  );

  static final darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: Color.fromARGB(255, 19, 21, 22), // Lighter blue
      onPrimary: Colors.white,
      secondary: Color.fromARGB(255, 52, 49, 57), // Muted lavender
      onSecondary: Colors.white,
      surface: Color(0xFF1E1E1E), // Dark gray for cards
      onSurface: Colors.white,
      onPrimaryContainer: Colors.white,
      onSecondaryContainer: Colors.white,
      onTertiaryContainer: Colors.white,
    ),
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212), // Soft dark gray
  );

    static final lightThemefromSeed = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 64, 58, 183),
      brightness: Brightness.light,
    ),
    useMaterial3: true,
    brightness: Brightness.light,
  );

  static final darkThemefromSeed = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 64, 58, 183),
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    brightness: Brightness.dark,
  );

  static ButtonStyle elevatedButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      minimumSize: const Size(150, 50),
    );
  }

  static ButtonStyle elevatedSecondaryButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      foregroundColor: Theme.of(context).colorScheme.onSecondary,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      minimumSize: const Size(150, 50),
    );
  }

  static ButtonStyle elevatedLargeButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      minimumSize: const Size(150, 50),
      textStyle: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
