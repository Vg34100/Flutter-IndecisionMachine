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
    return Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(child: Text(choice.name)),
            ],
          ),
        ),
      )
    );
  }
}