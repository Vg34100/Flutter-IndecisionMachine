import 'package:indecision_machine/models/category.dart';
import 'package:indecision_machine/models/category_model.dart'; 
import 'package:indecision_machine/views/category_view.dart';

class CategoryController {
  final CategoryView _view;
  final CategoryModel _model = CategoryModel(); 

  CategoryController(this._view) {
    _view.attachAddCategoryListener(_handleAddCategory);

    _initialize();
  }

  Future<void> _initialize() async {
    await _model.loadCategories();
    _view.updateCategoryList(_model.categories);
  }

  void _handleAddCategory() async {
    // Request the view to show the add category dialog
    Category? newCategory = await _view.showAddCategoryDialog();
    if (newCategory != null) {
      await _model.addCategory(newCategory);
      _view.updateCategoryList(_model.categories);
    }
  }

  void handleCategoryChanged(Category? newCategory) {
    if (newCategory != null) {
      _view.updateSelectedCategory(newCategory);
    }
  }

  List<Category> getCategories() {
    return _model.categories;
  }
}
