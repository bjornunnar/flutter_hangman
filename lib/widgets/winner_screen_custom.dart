import 'package:flutter/material.dart';

class WinnerScreenCustom extends StatelessWidget {
  String customTitle;
  WinnerScreenCustom({super.key, required this.customTitle});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('You Win!'),
      content: Column(
        children: [
          const Text("You correctly guessed the movie title:"),
          Text(customTitle,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
          const Text("... I'm assuming it's a movie title?"),
          const Text("I have no further information on this movie (if it is a movie), maybe you can google it.")
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