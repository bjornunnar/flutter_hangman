import 'package:flutter/material.dart';
import 'package:hangman/data/movie_details.dart';
import 'package:hangman/models/classes.dart';
import 'package:hangman/widgets/hangman.dart';

void main() {
  runApp(const Hangman());
}


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
