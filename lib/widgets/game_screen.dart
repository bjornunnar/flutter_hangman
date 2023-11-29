import 'package:flutter/material.dart';
import 'package:hangman/models/classes.dart';
import 'package:hangman/models/qwerty_keyboard.dart';

class GameScreen extends StatefulWidget {
  final Hint hint;
  final Function quitGame;
  GameScreen({super.key, required this.hint, required this.quitGame});

  @override
  State<GameScreen> createState() {
    return _GameScreenState();
  }
}

class _GameScreenState extends State<GameScreen> {
  String currentLetter = "_";

  void _updatePlaceholder(String letter) {
    setState(() {
      currentLetter = letter;
    });
  }

  void _confirmGuess(String letter) {
    setState(() {
      widget.hint.guessedLetters.add(letter);
      for (List row in qwertyKeyboard) {
        row.remove(letter);
      }
      currentLetter = "_";
    });
  }

  void _onQuit() {
    widget.quitGame();
  }

  List<List<String>> qwertyKeyboard = [
    ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
    ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
    ["Z", "X", "C", "V", "B", "N", "M"]
  ];

  @override
  Widget build(context) {
    final double availableHeight = MediaQuery.of(context).size.height;
    final double availableWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Column(
        children: [
          Row(
            children: [
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
            style: TextStyle(letterSpacing: 2.0, fontSize: 16),
          ),
          ElevatedButton.icon(
              onPressed: _onQuit,
              icon: const Icon(Icons.transit_enterexit),
              label: const Text("Quit")),
          Container(
            child: Text(
              currentLetter,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              Column(
                children: [
                  for (List row in qwertyKeyboard)
                    Row(
                      children: [
                        for (String key in row)
                          Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  _updatePlaceholder(key);
                                },
                                child: Text(key),
                              )),
                      ],
                    )
                ],
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {
                  _confirmGuess(currentLetter);
                },
                icon: const Icon(Icons.fort),
                label: const Text("GO"),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class GuessedLettersView extends StatelessWidget {
  final List guessedLetters;
  GuessedLettersView(this.guessedLetters, {super.key});
  //  late int lettersIndex = guessedLetters.length;

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
