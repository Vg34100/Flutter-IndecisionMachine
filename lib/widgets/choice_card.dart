import 'package:flutter/material.dart';
import 'package:indecision_machine/controllers/choice_controller.dart';
import 'package:indecision_machine/models/choice_model.dart';

class ChoiceCard extends StatelessWidget {
  final Choice choice;
  final ChoiceController _choiceController = ChoiceController();

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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      choice.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      choice.weight.name,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                )
              ),
              IconButton(onPressed: () {
                _choiceController.deleteChoice(choice);
                }, 
                icon: const Icon(Icons.delete)
              )
            ],
          ),
        ),
      )
    );
  }
}