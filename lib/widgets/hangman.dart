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
  Widget gameScreenWaiting = Container(); // placeholder value

  // setting default settings w/ medium difficulty
  Settings currentSettings = Settings(difficulty: 3);

  // displays custom title and/or year if user chooses
  bool displayCustomTitle = false;
  bool displayCustomYear = false;

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
        isScrollControlled: true,
        context: context,
        // builder takes the current settings object, and the updateSettings function
        builder: (ctx) => SettingsOverlay(
            currentSettings: currentSettings, updateSettings: updateSettings));
  }

  void _playGame() async {
    // if user sets a title/word, that's all we need
    if (currentSettings.customTitle != null) {
      Hint currentHint = constructHint(
          customTitle: currentSettings.customTitle,
          difficulty: currentSettings.difficulty);
      setState(() {
        gameOn = true;
        gameScreenWaiting = GameScreen(hint: currentHint, quitGame: quitGame);
      });
      // if user sets a year, we use that in our call to tmdb
    } else if (currentSettings.customYear != null) {
      Hint currentHint = constructHint(
        difficulty: currentSettings.difficulty,
        movie: await getMovie(
            difficulty: currentSettings.difficulty,
            year: currentSettings.customYear!));
      setState(() {
        gameOn = true;
        gameScreenWaiting = GameScreen(hint: currentHint, quitGame: quitGame);
      });
      // otherwise we just make the call using the current difficulty
    } else {
      Hint currentHint = constructHint(
        difficulty: currentSettings.difficulty,
        movie: await getMovie(difficulty: currentSettings.difficulty));
      setState(() {
        gameOn = true;
        gameScreenWaiting = GameScreen(hint: currentHint, quitGame: quitGame);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final double availableWidth = MediaQuery.of(context).size.width;

    // this only gets called when user clicks PLAY
    if (gameOn) {
      return Scaffold(
        body: Center(
          child: gameScreenWaiting,
        ),
      );
    } else {

      // and this is the starting screen
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("The Hanged Man",style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Text("(who only knew movie titles)",style: TextStyle(color: Colors.grey),),
              Image.asset("assets/images/hangman-light-trans.png",
                height: availableWidth > 500 ? 410 : availableWidth*0.8),
              
              SizedBox(width: availableWidth*0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                  onPressed: _openSettings, child: const Text("Settings")),
              ElevatedButton(onPressed: _playGame, child: const Text("Play!")),
              ],)),
              SizedBox(height: 5),
              Text("Difficulty setting: ${currentSettings.labels[currentSettings.difficulty]}"),
              SizedBox(height: 5),
              currentSettings.customTitle != null
              ? GestureDetector(
                onTap:() {
                  setState(() {
                    displayCustomTitle = !displayCustomTitle;
                  });
                },
                child: const Text("Custom Title is set.\nPress here to show the title on screen.")
                )
              : const Text("Playing with a Random Movie Title"),
              SizedBox(height: 5),
              // show custom title if user chooses. Else empty string, to keep layout steady.
              (displayCustomTitle && currentSettings.customTitle != null)
              ? Text("${currentSettings.customTitle!}") 
              : Text(""),
              currentSettings.customYear != null
              ? GestureDetector(
                onTap:() {
                  setState(() {
                    displayCustomYear = !displayCustomYear;
                  });
                },
                child: const Text("Playing with a set Custom Year.\nPress here to show on screen.")
                )
              : const Text("Playing with a Random Release Year"),
              (displayCustomYear && currentSettings.customYear != null) 
              ? Text(currentSettings.customYear!.toString())
              : Text(""),
              
              SizedBox(width: availableWidth*0.8,
              child:Row(
                children: [
                  Spacer(),
                  TextButton(
                    onPressed: _openCredits,
                    child: const Text("Credits"),
                  ),
              ],)
              ),
              
              
            ],
          ),
        ),
      );
    }
  }
}
