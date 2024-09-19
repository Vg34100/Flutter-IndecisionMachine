// lib/views/main_view.dart
import 'package:flutter/material.dart';
import 'package:indecision_machine/controllers/weight_controller.dart';
import 'package:indecision_machine/models/choice.dart';
import 'package:indecision_machine/models/weight.dart';
import 'package:indecision_machine/themes/app_themes.dart';
import 'package:indecision_machine/views/add_weight_view.dart';
import 'package:indecision_machine/views/choice_view.dart';
import 'package:indecision_machine/controllers/choice_controller.dart';
import 'package:indecision_machine/views/weight_view.dart';
import 'package:indecision_machine/widgets/choice_card.dart';
import 'package:indecision_machine/widgets/custom_app_bar.dart';
import 'package:indecision_machine/views/add_choice_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends State<MainView> implements ChoiceView, WeightView {
  // Listeners
  VoidCallback? _addListener;
  VoidCallback? _newAddListener;

  VoidCallback? _addWeightListener;


  VoidCallback? _removeListener;
  VoidCallback? _decideListener;

  // Data
  List<Choice> _choices = [];
  List<Weight> _weights = [];
  int? _selectedIndex;
  Weight? _selectedWeight;

  late ChoiceController _controller;
  late WeightController _weightController;


  @override
  void initState() {
    super.initState();
    // Instantiate the controller, passing this view
    _controller = ChoiceController(this);
    _weightController = WeightController(this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Implement ChoiceView interface methods
  @override
  void attachAddChoiceListener(VoidCallback listener) {
    _addListener = listener;
  }

  @override
  void attachNewAddListener(VoidCallback listener) {
    _newAddListener = listener;
  } 

  @override
  void attachRemoveChoiceListener(VoidCallback listener) {
    _removeListener = listener;
  }

  @override
  void attachDecideListener(VoidCallback listener) {
    _decideListener = listener;
  }

  @override
  void updateChoiceList(List<Choice> choices) {
    setState(() {
      _choices = choices;
    });
  }

  @override
  int getSelectedChoiceIndex() {
    return _selectedIndex ?? -1;
  }

  @override
  void clearSelection() {
    setState(() {
      _selectedIndex = null;
    });
  }


  // Implement WeightView methods
  @override
  void attachAddWeightListener(VoidCallback listener) { 
    setState(() => _addWeightListener = listener);
  }

  @override
  void updateWeightList(List<Weight> weights) { 
    setState(() => _weights = weights);
  }

  @override
  void updateSelectedWeight(Weight weight) { 
    setState(() => _selectedWeight = weight);
  }




  @override
  Future<Choice?> showAddChoiceDialog() async {
    return await showDialog<Choice>(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 400,
            minWidth: 300,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: AddChoiceView(weights: _weightController.getWeights(),),
        ),
      ),
    );
  }

  @override
  Future<Weight?> showAddWeightDialog() async {
    return await showDialog<Weight>(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 400,
            minWidth: 300,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: AddWeightView(existingWeights: _weightController.getWeights(),),
        ),
      ),
    );
  }

  @override
  void showOptionsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Add'),
          children: [
            SimpleDialogOption(
              child: const Text('Choice'),
              onPressed: () {
                Navigator.of(context).pop();
                if (_addListener != null) {
                  _addListener!();
                }
              },
            ),
            SimpleDialogOption(
              child: const Text('Category'),
              onPressed: () {
                Navigator.of(context).pop();
                if (_addWeightListener != null) {
                  _addWeightListener!();
                }
              },
            ),
          ],
        );
      },
    );
  }



  @override
  void showDecision(String decision) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Your Decision"),
        content: Text(decision),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  void showNoChoicesDialog() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "The Indecision Machine"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // "Choices" Label
            const Padding(
              padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Choices",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Scrollable list of choices
            Expanded(
              child: _choices.isEmpty
                  ? const Center(
                      child: Text("No choices available. Add some!"),
                    )
                  : ListView.builder(
                      itemCount: _choices.length,
                      itemBuilder: (context, index) {
                        final choice = _choices[index];
                        return ChoiceCard(
                          choice: choice,
                          isSelected: _selectedIndex == index,
                          onTap: () {
                            setState(() {
                              _selectedIndex = _selectedIndex == index ? null : index;
                            });
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar with "Decide", "Add", and "Remove" buttons
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ensures the column takes minimal vertical space
          children: [
            // "Decide" Button
            ElevatedButton.icon(
              onPressed: _choices.isNotEmpty ? _decideListener : null,
              style: MyAppThemes.elevatedLargeButtonStyle(context),
              icon: const Icon(Icons.window),
              label: const Text("Decide"),
            ),
            const SizedBox(height: 8.0),
            // "Add" and "Remove" Buttons in a Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // "Add" Button
                ElevatedButton.icon(
                  onPressed: _newAddListener,
                  style: MyAppThemes.elevatedButtonStyle(context),
                  icon: const Icon(Icons.add),
                  label: const Text("Add"),
                ),
                const SizedBox(width: 10,),
                // "Remove" Button
                ElevatedButton.icon(
                  onPressed: _selectedIndex != null ? _removeListener : null,
                  style: MyAppThemes.elevatedSecondaryButtonStyle(context),
                  icon: const Icon(Icons.delete),
                  label: const Text("Remove"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
