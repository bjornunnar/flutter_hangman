import 'package:flutter/material.dart';
import 'package:hangman/models/classes.dart';

class WinnerScreen extends StatelessWidget {
  Movie? movie;
  WinnerScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('You Win!'),
      content: Column(
        children: [
          const Text("You correctly guessed the movie:"),
          Text(movie!.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Image(image: NetworkImage(movie!.poster)),
          Text(movie!.overview,
          maxLines: 3,)
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // More buttons and stuff?
      ],
    );
  }
}