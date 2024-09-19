import 'package:flutter/material.dart';
import 'package:indecision_machine/models/weight.dart';

class AddWeightView extends StatefulWidget {
  final List<Weight> existingWeights;

  const AddWeightView({super.key, required this.existingWeights});


  @override
  AddWeightViewState createState() => AddWeightViewState();
}

class AddWeightViewState extends State<AddWeightView> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  int amount = 1;

  @override
  Widget build(BuildContext context) {
return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Material(
          color: Colors.transparent,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Add New Category',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      // Icon 
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                        child: IconButton(
                          icon: const Icon(Icons.check_box),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 4),
                      // Choice Name
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(labelText: 'Category Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter a category name';
                            }
                            if (widget.existingWeights.any((weight) => weight.name.toLowerCase() == value.toLowerCase())) {
                              return 'A category with this name already exists';
                            }
                            return null;
                          },                          
                          onSaved: (value) => name = value!,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Divider(),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Weight Amount'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a weight amount';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid integer';
                      }
                      int? parsedValue = int.tryParse(value);
                      if (parsedValue != null && parsedValue <= 0) {
                        return 'Please enter a positive integer';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // This will only be called if validation passes
                      amount = int.parse(value!);
                    },
                  ),
                  const SizedBox(height: 30),
                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        child: const Text('Add'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Weight newWeight = Weight(
                              name: name,
                              amount: amount,
                            );
                            Navigator.of(context).pop(newWeight); // Return the new choice
                          }
                        },
                      ),
                    ],
                  ),
              ],
            )
          ),
        ),
      )
    );
  }

}
