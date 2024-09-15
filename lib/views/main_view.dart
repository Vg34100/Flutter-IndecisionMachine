import 'package:flutter/material.dart';

class MainView extends StatefulWidget{
  const MainView({super.key});

  @override
  State<StatefulWidget> createState() => _MainViewState();

}

class _MainViewState extends State<MainView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Hello World?"),
    );
  }

}