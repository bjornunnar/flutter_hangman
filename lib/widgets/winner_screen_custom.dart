import 'package:flutter/material.dart';

class WinnerScreenCustom extends StatelessWidget {
  final String customTitle;
  const WinnerScreenCustom({super.key, required this.customTitle});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
       icon: const Icon(Icons.celebration_outlined),
      title: const Text('You Win!', textAlign: TextAlign.center,),
      content: Column(
        children: [
          const Text("You correctly guessed the movie:", textAlign: TextAlign.center,),
          const SizedBox(height: 10),
          Text(customTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
          const SizedBox(height: 30),
          const Text("... I'm assuming it's a movie title?",textAlign: TextAlign.center,),
          const Text("I have no further information on this movie (if it is a movie), maybe you can google it.",textAlign: TextAlign.center,)
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