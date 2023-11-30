import 'package:flutter/material.dart';

class GuessedLettersView extends StatelessWidget {
  final List guessedLetters;
  const GuessedLettersView(this.guessedLetters, {super.key});

  @override
  Widget build(context) {
    return GridView.builder(
      itemCount: guessedLetters.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext ctx, int index) {
        return GridTile(
          child: Text(guessedLetters[index].toString()),
        );
      },
    );
  }
}