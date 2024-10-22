import 'dart:ui';
import 'package:indecision_machine/models/category.dart';

abstract class CategoryView {
  // Attach a listener for adding a new category
  void attachAddCategoryListener(VoidCallback listener);

  // Update the list of categories in the view
  void updateCategoryList(List<Category> categories);

  // Update the selected category in the view
  void updateSelectedCategory(Category category);

  // Show a dialog for adding a new category and return the new category if confirmed
  Future<Category?> showAddCategoryDialog();
}
