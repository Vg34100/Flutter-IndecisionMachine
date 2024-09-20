import 'package:flutter/material.dart';
import 'package:indecision_machine/models/choice.dart';
import 'package:indecision_machine/models/weight.dart';
import 'package:uuid/uuid.dart';

class AddChoiceView extends StatefulWidget {
  final List<Weight> weights;

  const AddChoiceView({super.key, required this.weights});

  @override
  AddChoiceViewState createState() => AddChoiceViewState();
}

class AddChoiceViewState extends State<AddChoiceView> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  Weight? selectedWeight;


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
                        'Add New Choice',
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
                          decoration: const InputDecoration(labelText: 'Choice Name'),
                          validator: (value) => value!.isEmpty ? 'Enter a choice name' : null,
                          onSaved: (value) => name = value!,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Divider(),
                  DropdownButtonFormField<Weight>(
                    value: selectedWeight,
                    items: widget.weights.map((Weight weight) {
                      return DropdownMenuItem<Weight>(
                        value: weight,
                        child: Text('${weight.name} (${weight.amount})'),
                      );
                    }).toList(),
                    onChanged: (Weight? value) {
                      setState(() {
                        selectedWeight = value;
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Select Weight'),
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
                            Choice newChoice = Choice(
                              id: const Uuid().v4(),
                              name: name,
                              weight: selectedWeight ?? Weight(name: "Default", amount: 1),
                            );
                            Navigator.of(context).pop(newChoice); // Return the new choice
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