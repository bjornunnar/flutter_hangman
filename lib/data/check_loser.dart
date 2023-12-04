import 'package:hangman/models/classes.dart';

bool checkLoser(Hint hint){
  hint.tries--;
  if (hint.tries == 0){
    return true;
  }
  return false;
}