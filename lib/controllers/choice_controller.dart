// lib/controllers/choice_controller.dart
import 'package:indecision_machine/models/choice_model.dart';
import 'package:indecision_machine/models/choice.dart';
import 'package:indecision_machine/models/weight.dart';
import 'package:indecision_machine/models/weight_model.dart';
import 'package:indecision_machine/views/choice_view.dart';
import 'package:indecision_machine/views/weight_view.dart';
import 'package:uuid/uuid.dart';

class ChoiceController {
  final ChoiceView _view;
  final ChoiceModel _model = ChoiceModel();

  ChoiceController(this._view) {
    // Attach listeners
    _view.attachAddChoiceListener(_handleAddChoice);
    _view.attachNewAddListener(_handleNewAddChoice);

    _view.attachRemoveChoiceListener(_handleRemoveChoice);
    _view.attachDecideListener(_handleDecide);

    // Initialize
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

  void _handleDecide() {
    if (_model.choices.isEmpty) {
      _view.showNoChoicesDialog();
      return;
    }

    Choice chosen = _model.getRandomChoice();
    _view.showDecision(chosen.name);
  }

  void dispose() {
    // Clean up if necessary
  }
}
