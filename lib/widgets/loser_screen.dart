import 'package:flutter/material.dart';
import 'package:hangman/models/classes.dart';

class LoserScreen extends StatelessWidget {
  Movie? movie;
  LoserScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.flag_outlined),
      title: const Text('You Lose', textAlign: TextAlign.center,),
      content: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: double.infinity - 50,maxWidth: double.infinity - 50), // <-- TODO take a better look at this
        child: Column(
          children: [
            const Text("The movie in question was:", textAlign: TextAlign.center,),
            Text("${movie!.title} (${movie!.releaseYear})",
            textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image(image: NetworkImage(movie!.poster)),
            Text(movie!.overview,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,)
          ],
        ),
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