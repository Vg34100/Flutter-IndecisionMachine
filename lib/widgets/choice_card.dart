import 'package:flutter/material.dart';
import 'package:indecision_machine/models/choice_model.dart';

class ChoiceCard extends StatelessWidget {
  final Choice choice;
  final bool isSelected;
  final VoidCallback onTap;

  const ChoiceCard({
    super.key,
    required this.choice,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Define colors based on selection state using theme's color scheme
    final selectedColor = Theme.of(context).colorScheme.primary.withOpacity(0.2);
    final selectedIconColor = Theme.of(context).colorScheme.primary;

    return Card(
      color: isSelected ? selectedColor : null, // Highlight if selected
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        title: Text(choice.name),
        subtitle: Text("${choice.weight.name} (${choice.weight.amount})"),
        trailing: isSelected
            ? Icon(Icons.check_circle, color: selectedIconColor)
            : Icon(Icons.circle_outlined, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
        onTap: onTap, // Handle tap for selection/de-selection
      ),
    );
  }
}
