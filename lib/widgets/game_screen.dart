import 'package:flutter/material.dart';
import 'package:hangman/models/classes.dart';
import 'package:hangman/widgets/keyboard.dart';
import 'package:hangman/widgets/guessed_letters_view.dart';
import 'package:hangman/data/check_guess.dart';
import 'package:hangman/data/check_winner.dart';
import 'package:hangman/data/check_loser.dart';
import 'package:hangman/widgets/current_title.dart';


class GameScreen extends StatefulWidget {
  Hint hint;
  final Function quitGame;
  GameScreen({super.key, required this.hint, required this.quitGame});

  @override
  State<GameScreen> createState() {
    return _GameScreenState();
  }
}

class _GameScreenState extends State<GameScreen> {
  bool weHaveAWinner = false;
  bool weHaveALoser = false;
  
  void confirmGuess(String letter) {
      setState(() {
        // getting the current length of the guessed letters list, to check against
        // the same list after we run through and replace
        // there should be a better way to do this..?
        int beforeGuessIsChecked = widget.hint.guessedLetters.length;
        print(beforeGuessIsChecked);
        // compare the guess with the current word, return new hint object
        widget.hint = checkGuess(letter: letter, hint: widget.hint);
        print(widget.hint.hiddenTitleAsList);
        print(widget.hint.guessedLetters);

        if (beforeGuessIsChecked != widget.hint.guessedLetters.length){
          // drop number of available tries by 1 and check if game is lost
          weHaveALoser = checkLoser(widget.hint);
          if (weHaveALoser){
            // open a pop up dialog or similar with some info
          }
        } else {
          // if the guess was correct, check if game is won
          weHaveAWinner = checkWinner(widget.hint);
          if (weHaveAWinner){
            // open a pop up dialog or similar with some info
          }
        }
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
          CurrentTitle(title: widget.hint.hiddenTitleAsList),
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



