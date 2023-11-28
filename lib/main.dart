import 'package:flutter/material.dart';
import 'package:hangman/data/movie_details.dart';
import 'package:hangman/models/classes.dart';
import 'package:hangman/widgets/hangman.dart';

void main() {
      runApp(
      MaterialApp(
        themeMode: ThemeMode.system,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: const Hangman(),
      )
    );
}

var kColorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 37, 62, 175));
var kDarkColorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 23, 38, 105), brightness: Brightness.dark);

ThemeData lightTheme = ThemeData().copyWith(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: kColorScheme,
  appBarTheme: const AppBarTheme().copyWith(
    backgroundColor: kColorScheme.onPrimaryContainer,
    foregroundColor: kColorScheme.primaryContainer),
  cardTheme: const CardTheme().copyWith(
    color: kColorScheme.secondaryContainer,
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kColorScheme.primaryContainer,
    )
  ),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  useMaterial3: true,
  colorScheme: kDarkColorScheme,
  cardTheme: const CardTheme().copyWith(
    color: kDarkColorScheme.secondaryContainer,
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  ),
  
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kDarkColorScheme.primaryContainer,
      foregroundColor: kDarkColorScheme.onPrimaryContainer,
    )
  ),
);





// THIS IS ALL A TEST TO SEE THE DATA FROM THE API, WON'T BE USING THIS
class TMDBList extends StatefulWidget {
  TMDBList({super.key});

  @override
  State<TMDBList> createState() {
    return _TMBDListState();
  }
}


class _TMBDListState extends State<TMDBList> {
  @override
  Widget build(context) {
    return FutureBuilder<Movie>(
      future: getMovie(difficulty: 2), // here we call the api
      builder: (BuildContext context, AsyncSnapshot<Movie> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text('Roll Camera...'));
        } else {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Column(
              children: [
                // GameScreen(movie: currentMovie, hint: currentHint),
                Image(image: NetworkImage(snapshot.data!.poster)),
                Text(snapshot.data!.title),
                Text(snapshot.data!.releaseYear),
                ElevatedButton(onPressed: (){}, child: Text("Generate Hint")),

              ],
            ); // snapshot.data  :- get your object which is pass from your downloadData() function
          }
        }
      },
    );
  }
}
