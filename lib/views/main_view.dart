import 'package:flutter/material.dart';
import 'package:indecision_machine/models/choice_model.dart';
import 'package:indecision_machine/widgets/choice_card.dart';

class MainView extends StatefulWidget{
  const MainView({super.key});

  @override
  State<StatefulWidget> createState() => _MainViewState();

}

class _MainViewState extends State<MainView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChoiceCard(choice: Choice(id: '1', name: 'Do homework', weight: 1)),
    );
  }

}