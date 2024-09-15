class Weight {
  int amount;
  String name;

  Weight({
    required this.amount,
    required this.name
  });
}

class Choice {
  String id; // Identifier
  String name;

  Weight weight;

  Choice({
    required this.id,
    required this.name,
    required this.weight,
  });
}