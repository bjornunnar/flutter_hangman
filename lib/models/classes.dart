class Movie {
  int id;
  String title;
  String overview;
  String releaseYear;
  String poster;

  Movie({
    required this.id, 
    required this.title, 
    required this.overview, 
    required this.releaseYear, 
    required this.poster});
}

class Hint {
  int difficulty;
  int chosenYear;
  String cleanTitle;
  List cleanTitleAsList;
  String hiddenTitle;
  List hiddenTitleAsList;
  List guessedLetters;

  Hint({
    this.difficulty = 3, 
    this.chosenYear = 1, 
    required this.cleanTitle, 
    required this.cleanTitleAsList, 
    required this.hiddenTitle, 
    required this.hiddenTitleAsList, 
    required this.guessedLetters,});
}

class Settings{
  int difficulty;
  int? customYear;
  String? customTitle;

  Settings({
    required this.difficulty,
    this.customYear,
    this.customTitle,
  });
}