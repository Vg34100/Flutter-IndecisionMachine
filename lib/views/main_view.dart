import 'package:indecision_machine/controllers/choice_controller.dart';
import 'package:indecision_machine/controllers/theme_controller.dart';

import 'package:flutter/material.dart';
import 'package:indecision_machine/models/choice_model.dart';
import 'package:indecision_machine/views/add_choice_view.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget{
  const MainView({super.key});

  @override
  State<StatefulWidget> createState() => _MainViewState();

}

class _MainViewState extends State<MainView> {
  final ChoiceController _choiceController = ChoiceController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _choiceController.addListener(_onControllerUpdate);
    _loadChoices();
  }

  @override
  void dispose() {
    super.dispose();
    _choiceController.addListener(_onControllerUpdate);
  }

  void _onControllerUpdate() {
    setState(() {});
  }

  Future<void> _loadChoices() async {
    await _choiceController.loadChoices();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);


    return Scaffold(
      appBar: AppBar(
        title: const Text("The Indecision Machine"),
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

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : _choiceController.buildChoiceList(),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {}, 
                child: const Text("Make a Choice!")
              )
            ),
            IconButton(
              onPressed: () async {
                var newChoice = await showDialog<Choice>(
                  context: context, 
                  builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      ),
                    child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 400, // To not extend the modal across the whole width
                      minWidth: 300,
                      maxHeight: MediaQuery.of(context).size.height * 0.8,
                    ),
                    child: const AddChoiceView(),
                    ),
                  )
                );

              if (newChoice != null) {
              await _choiceController.addChoice(newChoice);
              }
              }, 
              icon: const Icon(Icons.add))
          ],
        )
      ),
    );
  }

}