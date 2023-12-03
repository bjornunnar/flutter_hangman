import 'package:hangman/models/classes.dart';
import 'package:hangman/data/clean_string.dart';

Hint constructHint({Movie? movie, String? customTitle, int? customYear, int difficulty = 3}){
  // If user has a custom title, we convert that one and use it for the Hint
  // if there is no custom title, the playGame function already delivers a movie object
  // so we use that instead
  // the String has to be nullable going in, leading to all these null checks..
  String cleanTitle = "";
  if (customTitle != null){
    String customTitleToString = customTitle.toString();
    cleanTitle = convertToEnglish(customTitleToString).toUpperCase();
    print("printing clean title 1 $cleanTitle");
  } else {
    cleanTitle = convertToEnglish(movie!.title).toUpperCase();
    print("printing clean title 2 $cleanTitle");
  }
  print("printing clean title 3: $cleanTitle");
  
  String hiddenTitle = cleanTitle.replaceAll(RegExp(r'[a-zA-Z]'), "_");
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
    tries: tries);
  return currentHint;
}

int setTries(int difficulty){
  // set default value for tries, and then we modify based on the difficulty setting
  int tries = 6; 
  switch (difficulty){
    case 5:{
      tries = 1;
      break;
    }
    case 4:{
      tries = 3;
      break;
    }
    case 2:{
      tries = 8;
      break;
    }
    case 1:{
      tries = 12;
      break;
    }
    default:{
      break;
    }
  }
  return tries;
}
