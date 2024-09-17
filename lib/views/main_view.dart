import 'package:flutter/material.dart';
import 'package:indecision_machine/controllers/choice_controller.dart';
import 'package:indecision_machine/models/choice_model.dart';
import 'package:indecision_machine/views/add_choice_view.dart';
import 'package:indecision_machine/widgets/choice_card.dart';
import 'package:indecision_machine/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<StatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  String? _selectedChoiceId; // Tracks the selected choice

  @override
  Widget build(BuildContext context) {
    final choiceController = Provider.of<ChoiceController>(context);

    return Scaffold(
      appBar: const CustomAppBar(title: "The Indecision Machine"),

      body: choiceController.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // "Choices" Label
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Choices",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Scrollable list of choices
                    Expanded(
                      child: choiceController.choices.isEmpty
                          ? const Center(
                              child: Text("No choices available. Add some!"),
                            )
                          : ListView.builder(
                              itemCount: choiceController.choices.length,
                              itemBuilder: (context, index) {
                                final choice = choiceController.choices[index];
                                return ChoiceCard(
                                  choice: choice,
                                  isSelected: choice.id == _selectedChoiceId,
                                  onTap: () {
                                    setState(() {
                                      if (_selectedChoiceId == choice.id) {
                                        _selectedChoiceId = null; // Deselect if already selected
                                      } else {
                                        _selectedChoiceId = choice.id; // Select the new choice
                                      }
                                    });
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
      // Bottom Navigation Bar with "Decide", "Add", and "Remove" buttons
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ensures the column takes minimal vertical space
          children: [
            // "Decide" Button
            ElevatedButton(
              onPressed: choiceController.choices.isNotEmpty
                  ? () {
                      try {
                        Choice chosen = choiceController.getRandomChoice();
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Your Decision"),
                            content: Text(chosen.name),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text("OK"),
                              ),
                            ],
                          ),
                        );
                      } catch (e) {
                        // Handle when no choices
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("No Choices Available"),
                            content: const Text("Please add some choices first."),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text("OK"),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  : null, // Disable if no choices
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                textStyle: Theme.of(context).textTheme.headlineLarge,
                minimumSize: const Size(double.infinity, 50), // Make it full-width and larger
              ),
              child: const Text("Decide"),
            ),
            const SizedBox(height: 8.0),
            // "Add" and "Remove" Buttons in a Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // "Add" Button
                ElevatedButton.icon(
                  onPressed: () async {
                    var newChoice = await showDialog<Choice>(
                      context: context,
                      builder: (context) => Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 400, // Prevent modal from being too wide
                            minWidth: 300,
                            maxHeight: MediaQuery.of(context).size.height * 0.8,
                          ),
                          child: const AddChoiceView(),
                        ),
                      ),
                    );
      
                    if (newChoice != null) {
                      await choiceController.addChoice(newChoice);
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add"),
                ),
                // "Remove" Button
                ElevatedButton(
                  onPressed: _selectedChoiceId != null
                      ? () async {
                          await choiceController.deleteChoice(_selectedChoiceId!);
                          setState(() {
                            _selectedChoiceId = null; // Clear selection after removal
                          });
                        }
                      : null, // Disable if no selection
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer, // Use theme's error color
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    minimumSize: const Size(150, 50), // Ensure consistent sizing
                  ),
                  child: const Text("Remove"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
