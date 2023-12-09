import 'package:flutter/material.dart';

class Credits extends StatefulWidget {
  const Credits({super.key});

  @override
  State<Credits> createState() {
    return _CreditsState();
  }
}

class _CreditsState extends State<Credits> {
  @override
  Widget build(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text("Made with:\nThe Movie Database API\nAnd tmdb_api package"),
        const Image(
          image: AssetImage("assets/images/tmdb-logo-placeholder.png"),
          width: 150,
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(
                  context); // closes the overlay by 'popping' the context given to the current build method
            },
            child: const Text("Close Credits")),
      ],
    );
  }
}
