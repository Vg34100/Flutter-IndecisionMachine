import 'package:flutter/material.dart';
import 'package:indecision_machine/controllers/theme_controller.dart';
import 'package:indecision_machine/models/choice_model.dart';
import 'package:indecision_machine/widgets/choice_card.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget{
  const MainView({super.key});

  @override
  State<StatefulWidget> createState() => _MainViewState();

}

class _MainViewState extends State<MainView> {

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text("The Indecision Machine"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                // Add the toggle button to the AppBar actions
        actions: [
          IconButton(
          icon: Icon(themeController.themeMode == ThemeMode.dark
              ? Icons.light_mode
              : Icons.dark_mode),
          onPressed: () {
            themeController.toggleTheme();
          },
          ),
        ],
      ),

      body: ChoiceCard(choice: Choice(id: '1', name: 'Do homework', weight: 1)),


      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {}, 
                child: Text("Make a Choice!")
              )
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.add))
          ],
        )
      ),
    );
  }

}