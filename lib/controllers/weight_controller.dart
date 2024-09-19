import 'package:indecision_machine/models/weight.dart';
import 'package:indecision_machine/models/weight_model.dart';
import 'package:indecision_machine/views/weight_view.dart';

class WeightController {
  final WeightView _view;
  final WeightModel _model = WeightModel();

  WeightController(this._view) {
    _view.attachAddWeightListener(_handleAddWeight);

    _initialize();
  }

  Future<void> _initialize() async {
    await _model.loadWeights();
    _view.updateWeightList(_model.weights);
  }


  void _handleAddWeight() async {
    // Request the view to show the add choice dialog
    Weight? newWeight = await _view.showAddWeightDialog();
    if (newWeight != null) {
      await _model.addWeight(newWeight);
      _view.updateWeightList(_model.weights);
    }
  }


  void handleWeightChanged(Weight? newWeight) {
    if (newWeight != null) {
      _view.updateSelectedWeight(newWeight);
    }
  }

  List<Weight> getWeights() {
    return _model.weights;
  }
}