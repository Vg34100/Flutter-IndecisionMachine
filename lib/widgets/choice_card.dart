import 'package:flutter/material.dart';
import 'package:indecision_machine/models/choice_model.dart';

class ChoiceCard extends StatelessWidget {
  final Choice choice;

  final VoidCallback onDelete;

  const ChoiceCard({
    super.key, 
    required this.choice,

    required this.onDelete,
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
                  onDelete();
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