import 'package:hangman/models/tmdb.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'dart:math' as math;
import 'package:hangman/models/classes.dart';

Future<Movie> getMovie({int year = 0, required int difficulty}) async {
  // the response has 20 items per page, so we get a random one of those
  final int itemOnPage = math.Random().nextInt(19);

  // the list is sorted by most popular, which gives us a sort of difficulty setting.
  // the user can widen the pool of available answers.
  final int pageNumber = (math.Random().nextInt(difficulty*2) + 1);

  // and if no year is given, we give ourselves a random one
  if (year == 0) {
    year = math.Random().nextInt(30) + 1980;
  }

  // this looks to be constant, we _can_ get the current value by
  // querying https://api.themoviedb.org/3/configuration but this should do.
  // size may be too large,
  // other sizes are: "w92", "w154", "w185", "w342", "w500", "w780", "original"
  const String posterPath = "http://image.tmdb.org/t/p/w185";

  Map response = await tmdb.v3.discover.getMovies(
    sortBy: SortMoviesBy.popularityDesc,
    year: year,
    page: pageNumber,
  );

  Movie currentMovie = Movie(
    id: response["results"][itemOnPage]["id"],
    title: response["results"][itemOnPage]["title"], 
    overview: response["results"][itemOnPage]["overview"], 
    releaseYear: response["results"][itemOnPage]["release_date"].toString().substring(0,4),
    poster: '$posterPath${response["results"][itemOnPage]["poster_path"]}'
    );

  return currentMovie;
}