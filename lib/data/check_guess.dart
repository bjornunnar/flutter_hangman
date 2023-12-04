import 'package:hangman/models/classes.dart';

Hint checkGuess({required String letter, required Hint hint}){
  bool correctGuess = false;
  for (int i = 0; i < hint.cleanTitleAsList.length; i++) {
    if (letter == hint.cleanTitleAsList[i]) {
      hint.hiddenTitleAsList[i] = letter;
      correctGuess = true;
    }
  }
  if (!correctGuess){
    hint.guessedLetters.add(letter);
  }
  return hint;
}
