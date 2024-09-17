import 'package:flutter/material.dart';

/*
 https://stackoverflow.com/questions/60232070/how-to-implement-dark-mode-and-light-mode-in-flutter
 I like having a theme option
*/
class MyAppThemes {
  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 64, 58, 183),
      brightness: Brightness.light,
    ),
    useMaterial3: true,
    brightness: Brightness.light,
  );

  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 64, 58, 183),
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    brightness: Brightness.dark,
  );

  static ButtonStyle elevatedButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      minimumSize: const Size(150, 50),
    );
  }

  static ButtonStyle elevatedSecondaryButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      minimumSize: const Size(150, 50),
    );
  }

    static ButtonStyle elevatedLargeButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      minimumSize: const Size(150, 50),
      textStyle: Theme.of(context).textTheme.headlineLarge,
    );
  }
}