import 'package:flutter/material.dart';

class LoserScreenCustom extends StatelessWidget {
  final String customTitle;
  const LoserScreenCustom({super.key, required this.customTitle});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
       icon: const Icon(Icons.flag_outlined),
      title: const Text('You Lose', textAlign: TextAlign.center,),
      content: Column(
        children: [
          const Text("The correct answer was:", textAlign: TextAlign.center,),
          const SizedBox(height: 10),
          Text(customTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
          const SizedBox(height: 30),
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