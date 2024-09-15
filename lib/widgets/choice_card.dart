import 'package:flutter/material.dart';
import 'package:indecision_machine/models/choice_model.dart';

class ChoiceCard extends StatelessWidget {
  final Choice choice;

  ChoiceCard({
    super.key, 
    required this.choice
  });

  @override
  Widget build(BuildContext context) {
    return Text(choice.name);
  }
}