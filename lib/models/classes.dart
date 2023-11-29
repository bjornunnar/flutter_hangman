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
  Movie? movie;
  int tries;
  String cleanTitle;
  List cleanTitleAsList;
  String hiddenTitle;
  List hiddenTitleAsList;
  List guessedLetters;

  Hint({
    this.movie,
    this.tries = 6,
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