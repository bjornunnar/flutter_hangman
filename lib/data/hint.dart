import 'package:hangman/models/classes.dart';
import 'package:hangman/data/clean_string.dart';

Hint constructHint({Movie? movie, String? customTitle, int? customYear}){
  String cleanTitle ="";
  if (customTitle != null){
    String cleanTitle = convertToEnglish(customTitle);
  } else {
    String cleanTitle = convertToEnglish(movie!.title);
  }
  
  String hiddenTitle = cleanTitle.replaceAll(RegExp(r'[a-zA-Z]'), "_");
  List cleanTitleAsList = cleanTitle.split("");
  List hiddenTitleAsList = hiddenTitle.split("");
  List guessedLetters = [];
  Hint currentHint = Hint(
    cleanTitle: cleanTitle, 
    hiddenTitle: hiddenTitle, 
    cleanTitleAsList: cleanTitleAsList, 
    hiddenTitleAsList: hiddenTitleAsList, 
    guessedLetters: guessedLetters);
  return currentHint;
}
