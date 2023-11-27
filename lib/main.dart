import 'package:flutter/material.dart';
import 'package:hangman/data/movie_title.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: TMDBList(),
        ),
      ),
    );
  }
}

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
    return FutureBuilder<String>(
      future: getMovieTitle(difficulty: 2), // here we call the api
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Please wait its loading...'));
        } else {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(
                child: Text(
                    '${snapshot.data}')); // snapshot.data  :- get your object which is pass from your downloadData() function
          }
        }
      },
    );
  }
}
