import 'package:indecision_machine/models/weight.dart';
import 'package:indecision_machine/models/category.dart'; // Import Tab model
import 'dart:convert';

class Choice {
  String id; // Identifier
  String name;
  Weight weight;
  List<Category> tabs; // List of tabs

  Choice({
    required this.id,
    required this.name,
    required this.weight,
    required this.tabs, // Initialize the list of tabs
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'weight': weight.toMap(),
      'tabs': tabs.map((tab) => tab.toMap()).toList(), // Convert tabs to list of maps
    };
  }

  /*
  https://stackoverflow.com/questions/53931513/store-data-as-an-object-in-shared-preferences-in-flutter
  Where the method of using SharedPreferences comes from.
  */

  factory Choice.fromMap(Map<String, dynamic> map) {
    return Choice(
      id: map['id'],
      name: map['name'],
      weight: Weight.fromMap(Map<String, dynamic>.from(map['weight'])),
      tabs: List<Category>.from(map['tabs']?.map((tabMap) => Category.fromMap(tabMap))), // Convert map to list of Tab objects
    );
  }

  String toJson() => json.encode(toMap());

  factory Choice.fromJson(String source) => Choice.fromMap(json.decode(source));
}
