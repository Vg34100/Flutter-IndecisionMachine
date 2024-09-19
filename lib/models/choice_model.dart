import 'dart:math';

import 'package:indecision_machine/models/choice.dart';
import 'package:indecision_machine/models/weight.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ChoiceModel {
  List<Choice> _choices = [];
  static const String choicesKey = 'choices_key';

  // Load choices from SharedPreferences
  Future<void> loadChoices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? choicesJson = prefs.getStringList(choicesKey);

    if (choicesJson != null) {
      _choices = choicesJson.map((choiceJson) => Choice.fromJson(choiceJson)).toList();
    } else {
      // Initialize with default choices if no data is found
      _choices = [
        Choice(
          id: const Uuid().v4(),
          name: "Work on 3390 Project",
          weight: Weight(amount: 1, name: "Unimportant"),
        ),
        Choice(
          id: const Uuid().v4(),
          name: "Playing Video Games",
          weight: Weight(amount: 3, name: "Important"),
        ),
      ];
      await saveChoices(); // Save the default choices
    }
  }

  // Save choices to SharedPreferences
  Future<void> saveChoices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> choicesJson = _choices.map((choice) => choice.toJson()).toList();
    await prefs.setStringList(choicesKey, choicesJson);
  }

  // Get a copy of the choices list
  List<Choice> get choices => List.unmodifiable(_choices);

  // Add a new choice
  Future<void> addChoice(Choice choice) async {
    _choices.add(choice);
    await saveChoices();
  }

  // Delete an existing choice by ID
  Future<void> deleteChoice(String id) async {
    _choices.removeWhere((c) => c.id == id);
    await saveChoices();
  }

  // Get a random choice based on weight
  Choice getRandomChoice() {
    if (_choices.isEmpty) {
      throw Exception("No choices available");
    }

    int totalWeight = _choices.fold(0, (sum, choice) => sum + choice.weight.amount);
    int randomWeight = Random().nextInt(totalWeight) + 1;

    int cumulativeWeight = 0;
    for (var choice in _choices) {
      cumulativeWeight += choice.weight.amount;
      if (randomWeight <= cumulativeWeight) {
        return choice;
      }
    }

    // Fallback, should not be reached
    return _choices.last;
  }

  // Helper method to get a choice by its ID
  Choice? getChoiceById(String id) {
    try {
      return _choices.firstWhere((choice) => choice.id == id);
    } catch (e) {
      return null;
    }
  }
}
