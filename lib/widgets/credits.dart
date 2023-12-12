import 'package:flutter/material.dart';

class Credits extends StatefulWidget {
  final double width;
  const Credits({super.key, required this.width});

  @override
  State<Credits> createState() {
    return _CreditsState();
  }
}

class _CreditsState extends State<Credits> {
  @override
  Widget build(context) {
    return Container(
      width: widget.width*0.8,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text("Made with:\nThe Movie Database API"),
        const Image(
          image: AssetImage("assets/images/tmdb-logo.png"),
          width: 150,
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(
                  context); // closes the overlay by 'popping' the context given to the current build method
            },
            child: const Text("Close Credits")),
      ],
    ),
    );
  }
}
