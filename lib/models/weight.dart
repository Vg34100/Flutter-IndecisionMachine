import 'dart:convert';

class Weight {
  int amount;
  String name;

  Weight({
    required this.amount,
    required this.name
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'name': name,
    };
  }

  factory Weight.fromMap(Map<String, dynamic> map) {
    return Weight(
      amount: map['amount'], 
      name: map['name']);
  }

  String toJson() => json.encode(toMap());

  factory Weight.fromJson(String source) => Weight.fromMap(json.decode(source));

}