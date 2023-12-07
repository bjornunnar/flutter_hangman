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
  List<String> cleanTitleAsList;
  String hiddenTitle;
  List<String> hiddenTitleAsList;
  List<String> guessedLetters;

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
  
  Map<int, String> labels = 
    {
      1: "Easy", 
      2: "Fine", 
      3: "Mid", 
      4: "Hard", 
      5: "OMG"
    };
  Map<int,String> get difficultyLabels{
    return labels;
  }
  
}

class ResponsiveSizes{
  double availableWidth;
  double padding;
  int numberOfLetters;

  ResponsiveSizes({
    required this.availableWidth,
    required this.padding,
    required this.numberOfLetters,
  });

  double get letterWidth{
    return (availableWidth-(padding*2*numberOfLetters))/(numberOfLetters+1.4);
  }
}
