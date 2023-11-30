import 'package:flutter/material.dart';
import 'package:hangman/data/construct_hint.dart';
import 'package:hangman/data/movie_details.dart';
import 'package:hangman/models/classes.dart';
import 'package:hangman/widgets/game_screen.dart';
import 'package:hangman/widgets/settings_screen.dart';
import 'package:hangman/widgets/credits.dart';

class Hangman extends StatefulWidget {
  const Hangman({super.key});

  @override
  State<Hangman> createState() {
    return _HangmanState();
  }
}

class _HangmanState extends State<Hangman> {
  bool gameOn = false; // game has not started yet
  Widget GameScreenWaiting = Container(); // placeholder value
  // setting default settings w/ medium difficulty
  Settings currentSettings = Settings(difficulty: 3);

  // quit function to be passed to GameScreen
  void quitGame() {
    setState(() {
      gameOn = false;
      currentSettings = Settings(difficulty: currentSettings.difficulty);
    });
  }

  // to be called when user saves on Settings overlay, updates the current settings
  void updateSettings(Settings data) {
    setState(() {
      currentSettings = data;
    });
  }

  // onclick to open the credits display
  void _openCredits() {
    showModalBottomSheet(
      useSafeArea:
          true, // makes sure that the overlay does not overlap with camera lens etc.
      context: context,
      // builder takes the current settings object, and the updateSettings function
      builder: (ctx) => const Credits(),
    );
  }

  // onClick to open the settings overlay. Takes as argument the current Settings
  void _openSettings() {
    showModalBottomSheet(
        useSafeArea:
            true, // makes sure that the overlay does not overlap with camera lens etc.
        isScrollControlled: false,
        context: context,
        // builder takes the current settings object, and the updateSettings function
        builder: (ctx) => SettingsOverlay(
            currentSettings: currentSettings, updateSettings: updateSettings));
  }

  void _playGame() async {
    if (currentSettings.customTitle != null) {
      Hint currentHint = constructHint(
          customTitle: currentSettings.customTitle,
          difficulty: currentSettings.difficulty);
      setState(() {
        gameOn = true;
        GameScreenWaiting = GameScreen(hint: currentHint, quitGame: quitGame);
      });
    } else if (currentSettings.customYear != null) {
      Hint currentHint = constructHint(
          movie: await getMovie(
              difficulty: currentSettings.difficulty,
              year: currentSettings.customYear!));
      setState(() {
        gameOn = true;
        GameScreenWaiting = GameScreen(hint: currentHint, quitGame: quitGame);
      });
    } else {
      Hint currentHint = constructHint(
          movie: await getMovie(difficulty: currentSettings.difficulty));
      setState(() {
        gameOn = true;
        GameScreenWaiting = GameScreen(hint: currentHint, quitGame: quitGame);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // this only gets called when user clicks PLAY
    if (gameOn) {
      return Scaffold(
        body: Center(
          child: GameScreenWaiting,
        ),
      );
    } else {
      // and this is the starting screen
      return Scaffold(
        body: Center(
          child: Column(
            children: [
              TextButton(
                  onPressed: _openSettings, child: const Text("Settings")),
              Text("${currentSettings.difficulty}"),
              Text("${currentSettings.customTitle}"),
              Text("${currentSettings.customYear}"),
              TextButton(onPressed: _playGame, child: const Text("Play!")),
              TextButton(
                onPressed: _openCredits,
                child: const Text("Credits"),
              ),
            ],
          ),
        ),
      );
    }
  }
}
