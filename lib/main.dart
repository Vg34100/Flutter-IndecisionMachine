import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:indecision_machine/controllers/theme_controller.dart';
import 'package:indecision_machine/themes/app_themes.dart';
import 'package:indecision_machine/views/main_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeController()),
        //ChangeNotifierProvider(create: (_) => ChoiceController()),
      ],
      child: const MainApp(),
    ),
  );
}

/*
 https://stackoverflow.com/questions/73006804/how-can-i-get-flutter-to-scroll-with-mouse-drag-instead-of-scroll-wheel-linux
 Count not get the scrolling to work, turns out there is a trackpad option
*/
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
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
          scrollBehavior: MyCustomScrollBehavior(),
        );
      },
    );
  }
}
