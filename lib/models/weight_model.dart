import 'package:indecision_machine/models/weight.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeightModel {
  List<Weight> _weights = [];
  static const String weightKey = 'weights_key';

  // Load
  Future<void> loadWeights() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? weightsJson = prefs.getStringList(weightKey);

    if (weightsJson != null) {
      _weights = weightsJson.map((weightJson) => Weight.fromJson(weightJson)).toList();
    } else {
      // Init
      _weights = [
        Weight(amount: 3, name: "Important"),
        Weight(amount: 1, name: "Unimportant"),
      ];
      await saveWeights();
    }
  }

  // Save 
  Future<void> saveWeights() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> weightsJson = _weights.map((weight) => weight.toJson()).toList();
    await prefs.setStringList(weightKey, weightsJson);
  }

  // Copy
  List<Weight> get weights => List.unmodifiable(_weights);

  // Add
  Future<void> addWeight(Weight weight) async {
    _weights.add(weight);
    await saveWeights();
  }
  
  // Delete
  Future<void> deleteWeight(String id) async {
    _weights.removeWhere((c) => c.name == id);
    await saveWeights();
  }

  // Get
  Weight? getChoiceById(String id) {
    try {
      return _weights.firstWhere((weight) => weight.name == id);
    } catch (e) {
      return null;
    }
  }

}