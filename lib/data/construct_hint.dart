import 'package:hangman/models/classes.dart';
import 'package:hangman/data/clean_string.dart';
import 'package:hangman/data/set_tries.dart';
import 'package:hangman/data/give_me_the_thes.dart';

Hint constructHint({Movie? movie, String? customTitle, int? customYear, int difficulty = 3}){
  // If user has a custom title, we convert that one and use it for the Hint
  // if there is no custom title, the playGame function already delivers a movie object
  // so we use that instead
  // the String has to be nullable going in, leading to all these null checks..
  String cleanTitle = "";
  if (customTitle != null){
    String customTitleToString = customTitle.toString();
    cleanTitle = convertToEnglish(customTitleToString).toUpperCase();
  } else {
    cleanTitle = convertToEnglish(movie!.title).toUpperCase();
  }
  
  String hiddenTitle = cleanTitle.replaceAll(RegExp(r'[a-zA-Z]'), "_");

  // might make this optional
  hiddenTitle = giveMeTheThes(cleanTitle, hiddenTitle);

  List<String> cleanTitleAsList = cleanTitle.split("");
  List<String> hiddenTitleAsList = hiddenTitle.split("");
  List<String> guessedLetters = [];
  
  int tries = setTries(difficulty);
  
  Hint currentHint = Hint(
    movie: movie,
    cleanTitle: cleanTitle, 
    hiddenTitle: hiddenTitle, 
    cleanTitleAsList: cleanTitleAsList, 
    hiddenTitleAsList: hiddenTitleAsList, 
    guessedLetters: guessedLetters,
    tries: tries,);
  return currentHint;
}



