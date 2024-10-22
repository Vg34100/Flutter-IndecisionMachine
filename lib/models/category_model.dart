import 'package:indecision_machine/models/category.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryModel {
  List<Category> _categories = [];
  static const String categoryKey = 'categories_key';

  // Load Categories
  Future<void> loadCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? categoriesJson = prefs.getStringList(categoryKey);

    if (categoriesJson != null) {
      _categories = categoriesJson.map((categoryJson) => Category.fromJson(categoryJson)).toList();
    } else {
      // Initialize with some default categories if necessary
      _categories = [
        Category(id: "1", name: "Work"),
        Category(id: "2", name: "Leisure"),
      ];
      await saveCategories();
    }
  }

  // Save Categories
  Future<void> saveCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> categoriesJson = _categories.map((category) => category.toJson()).toList();
    await prefs.setStringList(categoryKey, categoriesJson);
  }

  // Get Unmodifiable List of Categories
  List<Category> get categories => List.unmodifiable(_categories);

  // Add Category
  Future<void> addCategory(Category category) async {
    _categories.add(category);
    await saveCategories();
  }

  // Delete Category
  Future<void> deleteCategory(String id) async {
    _categories.removeWhere((category) => category.id == id);
    await saveCategories();
  }

  // Get Category by ID
  Category? getCategoryById(String id) {
    try {
      return _categories.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }
}
