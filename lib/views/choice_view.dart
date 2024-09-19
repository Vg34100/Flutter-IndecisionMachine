// lib/views/choice_view.dart
import 'dart:ui';

import 'package:indecision_machine/models/choice.dart';

abstract class ChoiceView {
  void attachAddChoiceListener(VoidCallback listener);
  void attachRemoveChoiceListener(VoidCallback listener);
  void attachDecideListener(VoidCallback listener);
  
  void updateChoiceList(List<Choice> choices);
  int getSelectedChoiceIndex();
  void clearSelection();
  
  Future<Choice?> showAddChoiceDialog();
  void showDecision(String decision);
  void showNoChoicesDialog();
}
