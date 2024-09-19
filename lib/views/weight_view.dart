import 'dart:ui';

import 'package:indecision_machine/models/weight.dart';

abstract class WeightView {

  void attachAddWeightListener(VoidCallback listener);
  void updateWeightList(List<Weight> weights);
  void updateSelectedWeight(Weight weight);
  
  Future<Weight?> showAddWeightDialog();


}