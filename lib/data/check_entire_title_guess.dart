import 'package:hangman/data/clean_string.dart';

// normalizes both strings,
// removes everything but a-z
// then compares the two.
// returns true if guess is correct

// fail case: If the title includes a character not listed in the convertToEnglish() function,
// and the user's guess uses a a-z character to represent that character,
// the character in the title will be wiped out by cleanup(), will not have a match, and
// this check will return false.
// unlikely to happen, and probably not worth it to include every conceivable character
// in the converToEnglish() map.
// in this case, the missing character will not be included in the "current title" display,
// which would indicate to user something is amiss..

bool checkEntireTitleGuess(String title, String guess){
  RegExp az = RegExp(r'[a-z]');
  title = convertToEnglish(title.toLowerCase());
  guess = convertToEnglish(guess.toLowerCase());

  if (cleanup(title, az) == cleanup(guess, az)){
    return true;
  } else {
    return false;
  }
}

String cleanup(String input, RegExp az){
  String result = "";
  for (int i = 0; i < input.length; i++) {
  String char = input[i];
  if (char.contains(az)) {
    result += char;
  } 
}
  return result;
}
