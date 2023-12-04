import 'package:flutter/material.dart';

class LoserScreenCustom extends StatelessWidget {
  String customTitle;
  LoserScreenCustom({super.key, required this.customTitle});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
       icon: const Icon(Icons.flag_outlined),
      title: const Text('You Lose', textAlign: TextAlign.center,),
      content: Column(
        children: [
          const Text("The movie in question was:", textAlign: TextAlign.center,),
          Text(customTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
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