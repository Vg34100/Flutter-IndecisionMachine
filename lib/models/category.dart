import 'dart:convert';

class Category {
  String id; // Identifier for the category
  String name; // Name of the category

  Category({
    required this.id,
    required this.name,
  });

  // Convert Category to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  // Factory constructor to create a Category from a Map
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) => Category.fromMap(json.decode(source));

  // Override the equality operator to compare based on 'id'
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category && other.id == id;
  }

  // Override hashCode to be consistent with equality
  @override
  int get hashCode => id.hashCode;
}
