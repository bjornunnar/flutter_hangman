import 'package:hangman/models/classes.dart';

bool checkWinner(Hint hint){
  print("checking winner");
  print(hint.hiddenTitleAsList.join());
  print(hint.cleanTitleAsList.join());
  if (hint.hiddenTitleAsList.join() == hint.cleanTitleAsList.join()){
    print("game won"); // remove this
    return true;
  }
  return false;
}