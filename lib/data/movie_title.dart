import 'package:hangman/models/tmdb.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'dart:math' as math;

Future<String> getMovieTitle({int year = 0, required int difficulty}) async {
  // the response has 20 items per page, so we get a random one of those
  final int itemOnPage = math.Random().nextInt(19);

  // the list is sorted by most popular, which gives us a sort of difficulty setting.
  // the user can widen the pool of available answers.
  final int pageNumber = (math.Random().nextInt(9) + 1) * difficulty;

  // and if no year is given, we give ourselves a random one
  if (year == 0) {
    year = math.Random().nextInt(30) + 1980;
  }

  Map response = await tmdb.v3.discover.getMovies(
    sortBy: SortMoviesBy.popularityDesc,
    year: year,
    page: pageNumber,
  );
  final String movieTitle = response["results"][itemOnPage]["title"];
  return movieTitle;
}

// we want to have more details on the movie for hints.
// could create a movie class to return a bit more info

class Movie({required String title, required String overview, required DateTime releaseDate})


