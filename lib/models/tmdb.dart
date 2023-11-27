import 'package:tmdb_api/tmdb_api.dart';
import 'package:hangman/env/env.dart';

final tmdb = TMDB(
  //TMDB instance
  ApiKeys(Env.key1, Env.token), //ApiKeys instance with your keys,
);
