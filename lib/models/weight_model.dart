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
}