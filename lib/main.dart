import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:indecision_machine/controllers/theme_controller.dart';
import 'package:indecision_machine/themes/app_themes.dart';
import 'package:indecision_machine/views/main_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeController(),
      builder: (context, _) {
        final themeController = Provider.of<ThemeController>(context);
        return MaterialApp(
          title: 'Habit Tracker',
          theme: MyAppThemes.lightTheme,
          darkTheme: MyAppThemes.darkTheme,
          themeMode: themeController.themeMode,
          home: const MainView(),
          scrollBehavior: const MaterialScrollBehavior().copyWith( dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},),
        );
      },
    );
  }
}
