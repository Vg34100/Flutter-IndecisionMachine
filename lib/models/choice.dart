import 'package:indecision_machine/models/weight.dart';

import 'dart:convert';

class Choice {
  String id; // Identifier
  String name;

  Weight weight;

  Choice({
    required this.id,
    required this.name,
    required this.weight,
  });

    Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'weight': weight.toMap(),
    };
  }

  factory Choice.fromMap(Map<String, dynamic> map) {
    return Choice(
      id: map['id'], 
      name: map['name'],
      weight: Weight.fromMap(Map<String, dynamic>.from(map['weight'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory Choice.fromJson(String source) => Choice.fromMap(json.decode(source));
}