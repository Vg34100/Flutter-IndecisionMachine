import 'package:flutter/material.dart';
import 'package:indecision_machine/controllers/choice_controller.dart';
import 'package:indecision_machine/controllers/theme_controller.dart';
import 'package:indecision_machine/widgets/choice_card.dart';
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

      body: isLoading ? Text("Loading...") : ChoiceCard(choice: _choiceController.choices[0]),


      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {}, 
                child: const Text("Make a Choice!")
              )
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.add))
          ],
        )
      ),
    );
  }

}