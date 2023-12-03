import 'package:hangman/models/classes.dart';

bool checkLoser(Hint hint){
  print("checking loser");
  hint.tries--;
  if (hint.tries == 0){
    print("game lost"); // remove this
    return true;
  }
  return false;
}