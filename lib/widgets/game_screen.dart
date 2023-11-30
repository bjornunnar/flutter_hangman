import 'package:flutter/material.dart';
import 'package:hangman/models/classes.dart';
import 'package:hangman/widgets/keyboard.dart';
import 'package:hangman/widgets/guessed_letters_view.dart';


class GameScreen extends StatefulWidget {
  final Hint hint;
  final Function quitGame;
  const GameScreen({super.key, required this.hint, required this.quitGame});

  @override
  State<GameScreen> createState() {
    return _GameScreenState();
  }
}

class _GameScreenState extends State<GameScreen> {
  
  void confirmGuess(String letter) {
      setState(() {
        widget.hint.guessedLetters.add(letter);
      });
  }

  void _onQuit() {
    widget.quitGame();
  }

  @override
  Widget build(context) {
    // not sure if this is needed, current implementation is off
    final double availableHeight = MediaQuery.of(context).size.height;
    final double availableWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Column(
        children: [
          Row(
            children: [
              // these height and width settings don't make sense
              Container(
                width: availableWidth * 0.65,
                height: 300,
                color: Colors.blue,
              ),
              Container(
                  height: availableWidth * 0.3,
                  width: 300,
                  child: GuessedLettersView(widget.hint.guessedLetters)),
            ],
          ),
          Text(widget.hint.cleanTitle),
          Text(
            widget.hint.hiddenTitle,
            style: const TextStyle(letterSpacing: 2.0, fontSize: 16),
          ),
          ElevatedButton.icon(
              onPressed: _onQuit,
              icon: const Icon(Icons.transit_enterexit),
              label: const Text("Quit")),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Keyboard(confirmGuess: confirmGuess),
            ],
          )
        ],
      ),
    );
  }
}



