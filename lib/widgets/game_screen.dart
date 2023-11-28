import 'package:flutter/material.dart';
import 'package:hangman/models/classes.dart';

class GameScreen extends StatefulWidget {
  final Movie movie;
  final Hint hint;
  GameScreen({super.key, required this.movie, required this.hint});

  @override
  State<GameScreen> createState() {
    return _GameScreenState();
  }
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(context) {
    return Text("");
  }
}