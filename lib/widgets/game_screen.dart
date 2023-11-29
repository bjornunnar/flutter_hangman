import 'package:flutter/material.dart';
import 'package:hangman/models/classes.dart';

class GameScreen extends StatefulWidget {
  final Hint hint;
  GameScreen({super.key, required this.hint});

  @override
  State<GameScreen> createState() {
    return _GameScreenState();
  }
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(context) {
    return Column(
      children: [
        Text(widget.hint.cleanTitle),
        Text(widget.hint.hiddenTitle),
      ],
    );
  }
}