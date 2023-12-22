import 'package:hangman/models/classes.dart';

Hint checkGuess({required String letter, required Hint hint}){
  bool correctGuess = false;
  for (int i = 0; i < hint.cleanTitleAsList.length; i++) {
    // check specifically if the letter is undiscovered in the hidden title
    // because words like "the" may be given already
    if (letter == hint.cleanTitleAsList[i] && hint.hiddenTitleAsList[i] == "_") {
      hint.hiddenTitleAsList[i] = letter;
      correctGuess = true;
    }
  }
  if (!correctGuess){
    hint.guessedLetters.add(letter);
  }
  return hint;
}
