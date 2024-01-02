# hangman

This is a version of hangman where the phrase to guess is a semi-random movie title from The Movie Database.

Along with the movie title, we also fetch a movie poster image, the release year and the synopsis, to show the user after each round.

The user can set a level of difficulty, which both affects their number of allowed fails each game, and also the range of titles they can get: The higher the difficulty, the higher the chance for a (relatively) obscure movie to play with.

The user can set a custom release year, which is then used to query a movie for the game to use.
This is a bit of an approximation it looks like, as the release year of the movie returned by the API does not always exactly match the one requested.

The user can also set a custom title/word/phrase to play with.

The user can only set one of these two custom options, and if either is given, they can toggle on/off its visibility on the starting screen.

The user can opt to play in "marathon mode", which does not reset the keyboard after a successful round.

The titles are "sanitized" to get rid of non-english language characters.

The user guesses one letter at a time until they win or lose.

Or they can choose to guess the entire title to win or lose instantly.

The game requires a TMDB API key, which needs to be set locally, details in /lib/env/env.dart .
