import 'package:flutter/material.dart';
import 'package:indecision_machine/models/category.dart';

class AddCategoryView extends StatefulWidget {
  final List<Category> existingCategories;

  const AddCategoryView({super.key, required this.existingCategories});

  @override
  AddCategoryViewState createState() => AddCategoryViewState();
}

class AddCategoryViewState extends State<AddCategoryView> {
  final _formKey = GlobalKey<FormState>();
  String name = '';

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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                      child: IconButton(
                        icon: const Icon(Icons.folder),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'Category Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter a category name';
                          }
                          if (widget.existingCategories.any((category) => category.name.toLowerCase() == value.toLowerCase())) {
                            return 'A category with this name already exists';
                          }
                          return null;
                        },
                        onSaved: (value) => name = value!,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.onPrimary, // Use onPrimary color for the text
                    ),
                  ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      child: const Text('Add'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          Category newCategory = Category(
                            id: DateTime.now().millisecondsSinceEpoch.toString(), // Generate a unique ID
                            name: name,
                          );
                          Navigator.of(context).pop(newCategory); // Return the new category
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.onPrimary, // Use onPrimary color for the text
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
