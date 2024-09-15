import 'package:flutter/material.dart';
import 'package:indecision_machine/models/choice_model.dart';
import 'package:indecision_machine/widgets/choice_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ChoiceController extends ChangeNotifier {
  List<Choice> choices = [];
  static const String choicesKey = 'choices_key';

  Future<void> loadChoices() async {
    if (choices.isNotEmpty) {
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? choicesJson = prefs.getStringList(choicesKey);

    if (choicesJson != null) {
      choices = choicesJson.map((choiceJson) => Choice.fromJson(choiceJson)).toList();
    } else {
      // Initialize with default choices if no data is found
      choices = [
        Choice(
          id: const Uuid().v4(), 
          name: "Work on 3390 Project", 
          weight: Weight(amount: 1, name: "Unimportant")
        ),
        Choice(
          id: const Uuid().v4(), 
          name: "Playing Video Games", 
          weight: Weight(amount: 3, name: "Important")
        ),
      ];
      // save the choices
    }
  }

  Future<void> saveChoices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> choicesJson = choices.map((choice) => choice.toJson()).toList();
    await prefs.setStringList(choicesKey, choicesJson);
  }

  Future<void> addChoice(Choice choice) async {
    choices.add(choice);
    await saveChoices();
    notifyListeners(); 
  }

  Future<void> deleteChoice(Choice choice) async {
    choices.removeWhere((c) => c.id == choice.id);
    await saveChoices();
    notifyListeners();
  }

  Widget buildChoiceList() {
    List<Widget> choiceListWidgets = [];

    choiceListWidgets.addAll(
      choices.map((choice) => ChoiceCard(
        choice: choice, 
        onDelete: () => deleteChoice(choice)))
    );

    return ListView(
      children: choiceListWidgets,
    );
  }

}