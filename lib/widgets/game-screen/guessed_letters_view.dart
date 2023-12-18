import 'package:flutter/material.dart';
import 'package:hangman/models/classes.dart';

class GuessedLettersView extends StatelessWidget {
  final List<String> guessedLetters;
  final ResponsiveSizes titleLetterWidth;
  const GuessedLettersView({
    super.key, 
    required this.guessedLetters, 
    required this.titleLetterWidth,
    });

  @override
  Widget build(context) {

    return GridView.builder(
      reverse: true,
      itemCount: guessedLetters.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, 
            mainAxisSpacing: (titleLetterWidth.padding*2), 
            crossAxisSpacing: (titleLetterWidth.padding*2),
          ),
      itemBuilder: (BuildContext ctx, int index) {
        return GridTile(
          child: Container(
            width: titleLetterWidth.letterWidth,
            height: titleLetterWidth.letterWidth,
            decoration: const BoxDecoration(
              boxShadow: [BoxShadow(
                color: Colors.redAccent, blurRadius: 1, offset: Offset(1, 1)
                )
              ],
              borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
              color: Colors.red),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    guessedLetters[index].toString(), 
                    style: const TextStyle(
                      color: Colors.white, 
                      fontWeight: FontWeight.bold, 
                      fontSize: 16)
                      ),
                )
              )
          ),
        );
      },
    );
  }
}


