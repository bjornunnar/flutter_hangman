import 'package:hangman/models/classes.dart';

bool checkWinner(Hint hint){
  if (hint.hiddenTitleAsList.join() == hint.cleanTitleAsList.join()){
    return true;
  }
  return false;
}