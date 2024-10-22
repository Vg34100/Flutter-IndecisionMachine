import 'package:flutter/material.dart';
import 'package:indecision_machine/controllers/weight_controller.dart';
import 'package:indecision_machine/controllers/choice_controller.dart';
import 'package:indecision_machine/controllers/category_controller.dart'; // Import CategoryController
import 'package:indecision_machine/models/choice.dart';
import 'package:indecision_machine/models/weight.dart';
import 'package:indecision_machine/models/category.dart'; // Import Category model
import 'package:indecision_machine/themes/app_themes.dart';
import 'package:indecision_machine/views/add_weight_view.dart';
import 'package:indecision_machine/views/add_choice_view.dart';
import 'package:indecision_machine/views/add_category_view.dart'; // Import AddCategoryView
import 'package:indecision_machine/views/choice_view.dart';
import 'package:indecision_machine/views/weight_view.dart';
import 'package:indecision_machine/views/category_view.dart'; // Import CategoryView
import 'package:indecision_machine/widgets/choice_card.dart';
import 'package:indecision_machine/widgets/custom_app_bar.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends State<MainView> implements ChoiceView, WeightView, CategoryView {
  // Listeners
  VoidCallback? _addListener;
  VoidCallback? _newAddListener;
  VoidCallback? _addWeightListener;
  VoidCallback? _addCategoryListener; // New listener for adding categories
  VoidCallback? _removeListener;
  VoidCallback? _decideListener;

  // Data
  List<Choice> _choices = [];
  List<Category> _categories = []; // Categories list
  List<Choice> _filteredChoices = []; // Filtered choices based on category selection
  Category? _selectedCategory; // Track selected category for filtering
  int? _selectedIndex;

  late ChoiceController _controller;
  late WeightController _weightController;
  late CategoryController _categoryController; // New controller for categories

  @override
  void initState() {
    super.initState();
    // Instantiate controllers, passing this view
    _controller = ChoiceController(this);
    _weightController = WeightController(this);
    _categoryController = CategoryController(this); // Initialize CategoryController

    // Initially, all choices will be shown (i.e., the "ALL" filter)
    _filteredChoices = _choices;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Implement ChoiceView interface methods
  @override
  void attachAddChoiceListener(VoidCallback listener) {
    _addListener = listener;
  }

  @override
  void attachNewAddListener(VoidCallback listener) {
    _newAddListener = listener;
  }

  @override
  void attachRemoveChoiceListener(VoidCallback listener) {
    _removeListener = listener;
  }

  @override
  void attachDecideListener(VoidCallback listener) {
    _decideListener = listener;  // No need to call the controller directly
  }



  @override
  void updateChoiceList(List<Choice> choices) {
    setState(() {
      _choices = choices;
      _filterChoices(); // Apply the current filter when choices are updated
    });
  }

  @override
  int getSelectedChoiceIndex() {
    return _selectedIndex ?? -1;
  }

  @override
  void clearSelection() {
    setState(() {
      _selectedIndex = null;
    });
  }

  // Implement WeightView interface methods
  @override
  void attachAddWeightListener(VoidCallback listener) {
    setState(() => _addWeightListener = listener);
  }

  @override
  void updateWeightList(List<Weight> weights) {}

  @override
  void updateSelectedWeight(Weight weight) {}

  @override
  Future<Choice?> showAddChoiceDialog() async {
    return await showDialog<Choice>(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 400,
            minWidth: 300,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: AddChoiceView(
            weights: _weightController.getWeights(),
            categories: _categoryController.getCategories(), // Pass available categories
          ),
        ),
      ),
    );
  }

  @override
  Future<Weight?> showAddWeightDialog() async {
    return await showDialog<Weight>(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 400,
            minWidth: 300,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: AddWeightView(existingWeights: _weightController.getWeights()),
        ),
      ),
    );
  }

  // Implement CategoryView interface methods
  @override
  void attachAddCategoryListener(VoidCallback listener) {
    setState(() => _addCategoryListener = listener);
  }

  @override
  void updateCategoryList(List<Category> categories) {
    setState(() {
      _categories = categories;
    });
  }

  @override
  void updateSelectedCategory(Category category) {}

  @override
  Future<Category?> showAddCategoryDialog() async {
    return await showDialog<Category>(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 400,
            minWidth: 300,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: AddCategoryView(existingCategories: _categoryController.getCategories()),
        ),
      ),
    );
  }

  // Helper function to return the currently filtered choices
  List<Choice> getFilteredChoices() {
    return _filteredChoices;
  }

  void _filterChoices() {
    setState(() {
      if (_selectedCategory == null) {
        // Show all choices when "ALL" is selected
        _filteredChoices = _choices;
      } else {
        // Only show choices that contain the selected category
        _filteredChoices = _choices
            .where((choice) => choice.tabs.contains(_selectedCategory))
            .toList();
      }
    });
  }

  @override
  void showOptionsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Add'),
          children: [
            SimpleDialogOption(
              child: const Text('Choice'),
              onPressed: () {
                Navigator.of(context).pop();
                if (_addListener != null) {
                  _addListener!();
                }
              },
            ),
            SimpleDialogOption(
              child: const Text('Category'),
              onPressed: () {
                Navigator.of(context).pop();
                if (_addCategoryListener != null) {
                  _addCategoryListener!();
                }
              },
            ),
            SimpleDialogOption(
              child: const Text('Weight'),
              onPressed: () {
                Navigator.of(context).pop();
                if (_addWeightListener != null) {
                  _addWeightListener!();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void showDecision(String decision) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Your Decision"),
        content: Text(decision),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  void showNoChoicesDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("No Choices Available"),
        content: const Text("Please add some choices first."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "The Indecision Machine"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Horizontal scrolling list of categories
            SizedBox(
              height: 40, // Adjust height based on your design
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length + 1, // Add one for "ALL" option
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _buildCategoryChip(
                      category: null, // "ALL" category
                      label: "ALL",
                      isSelected: _selectedCategory == null,
                    );
                  }
                  final category = _categories[index - 1];
                  return _buildCategoryChip(
                    category: category,
                    label: category.name,
                    isSelected: _selectedCategory == category,
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            // "Choices" Label
            const Padding(
              padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Choices",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Scrollable list of choices
            Expanded(
              child: _filteredChoices.isEmpty
                  ? const Center(
                      child: Text("No choices available. Add some!"),
                    )
                  : ListView.builder(
                      itemCount: _filteredChoices.length,
                      itemBuilder: (context, index) {
                        final choice = _filteredChoices[index];
                        return ChoiceCard(
                          choice: choice,
                          isSelected: _selectedIndex == index,
                          onTap: () {
                            setState(() {
                              _selectedIndex = _selectedIndex == index ? null : index;
                            });
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar with "Decide", "Add", and "Remove" buttons
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ensures the column takes minimal vertical space
          children: [
            // "Decide" Button
            ElevatedButton.icon(
              onPressed: _filteredChoices.isNotEmpty ? _decideListener : null,
              style: MyAppThemes.elevatedLargeButtonStyle(context),
              icon: const Icon(Icons.window),
              label: const Text("Decide"),
            ),
            const SizedBox(height: 8.0),
            // "Add" and "Remove" Buttons in a Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // "Add" Button
                ElevatedButton.icon(
                  onPressed: _newAddListener,
                  style: MyAppThemes.elevatedButtonStyle(context),
                  icon: const Icon(Icons.add),
                  label: const Text("Add"),
                ),
                const SizedBox(width: 10),
                // "Remove" Button
                ElevatedButton.icon(
                  onPressed: _selectedIndex != null ? _removeListener : null,
                  style: MyAppThemes.elevatedSecondaryButtonStyle(context),
                  icon: const Icon(Icons.delete),
                  label: const Text("Remove"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a category chip (for the horizontal category bar)
  Widget _buildCategoryChip({
    required Category? category,
    required String label,
    required bool isSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (bool selected) {
          setState(() {
            _selectedCategory = selected ? category : null;
            _filterChoices(); // Update the filtered choices
          });
        },
      ),
    );
  }
}
