import 'package:flutter/material.dart';
import 'package:hangman/models/tmdb.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: TMDBList(),
        ),
      ),
    );
  }
}

class TMDBList extends StatelessWidget{
  const TMDBList({super.key});

  Future<String> _getThing() async {
    Map thing = await tmdb.v3.trending.getTrending(mediaType: MediaType.movie, timeWindow: TimeWindow.day);
    print(thing["results"]);
    return thing["results"];
  }

  @override
  Widget build(context) {
    final trendingList = _getThing().then(value => value);
    return Text(trendingList);
  }
}