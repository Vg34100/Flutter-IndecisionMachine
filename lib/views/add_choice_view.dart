import 'package:flutter/material.dart';
import 'package:indecision_machine/models/choice_model.dart';
import 'package:uuid/uuid.dart';

class AddChoiceView extends StatefulWidget {
  const AddChoiceView({Key? key}) : super(key: key);

  @override
  _AddChoiceViewState createState() => _AddChoiceViewState();
}

class _AddChoiceViewState extends State<AddChoiceView> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  int amount = 1;
  String weightName = 'Unimportant';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                // Weight Name
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Weight Name'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Enter weight name' : null,
                  onSaved: (value) => weightName = value!,
                ),
                const SizedBox(height: 10),
                // Weight Amount
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Weight Amount'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Enter weight amount' : null,
                  onSaved: (value) => amount = int.parse(value!),
                ),
                const Divider(),
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
                            weight: Weight(name: weightName, amount: amount,),
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
      )
    );
  }
  
}