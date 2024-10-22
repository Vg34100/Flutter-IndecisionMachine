// lib/controllers/choice_controller.dart
import 'package:indecision_machine/models/category.dart';
import 'package:indecision_machine/models/choice_model.dart';
import 'package:indecision_machine/models/choice.dart';
import 'package:indecision_machine/views/choice_view.dart';
class ChoiceController {
  final ChoiceView _view;
  final ChoiceModel _model = ChoiceModel();
  Category? _selectedCategory; // Track the selected category

  ChoiceController(this._view) {
    // Attach listeners
    _view.attachAddChoiceListener(_handleAddChoice);
    _view.attachNewAddListener(_handleNewAddChoice);
    _view.attachRemoveChoiceListener(_handleRemoveChoice);
    _view.attachDecideListener(() {
      _handleDecide(_view.getFilteredChoices());  // Get filtered choices from the view
    });

    _initialize();
  }

  Future<void> _initialize() async {
    await _model.loadChoices();
    _view.updateChoiceList(_model.choices);
  }

  void _handleAddChoice() async {
    // Request the view to show the add choice dialog
    Choice? newChoice = await _view.showAddChoiceDialog();
    if (newChoice != null) {
      await _model.addChoice(newChoice);
      _view.updateChoiceList(_model.choices);
      _view.clearSelection();
    }
  }

  void _handleNewAddChoice() {
    _view.showOptionsDialog();
  }

  void _handleRemoveChoice() async {
    // Get the selected choice index
    int selectedIndex = _view.getSelectedChoiceIndex();
    if (selectedIndex == -1) return;

    // Remove the choice from the model
    Choice choiceToRemove = _model.choices[selectedIndex];
    await _model.deleteChoice(choiceToRemove.id);

    // Update the view
    _view.updateChoiceList(_model.choices);
    _view.clearSelection();
  }

  // Updated _handleDecide to accept filtered choices
  void _handleDecide(List<Choice> filteredChoices) {
    if (filteredChoices.isEmpty) {
      _view.showNoChoicesDialog();
      return;
    }

    // Select a random choice from the filtered list
    Choice chosen = _model.getRandomChoiceFromList(filteredChoices);
    _view.showDecision(chosen.name);
  }

  // Method to update the selected category
  void updateSelectedCategory(Category? category) {
    _selectedCategory = category;
  }

  void dispose() {
    // Clean up if necessary
  }
}
