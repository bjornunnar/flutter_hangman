import 'package:flutter/material.dart';
import 'package:hangman/data/construct_hint.dart';
import 'package:hangman/data/movie_details.dart';
import 'package:hangman/models/classes.dart';
import 'package:hangman/widgets/game-screen/game_screen.dart';
import 'package:hangman/widgets/start-screen/settings_screen.dart';
import 'package:hangman/widgets/start-screen/credits.dart';

class Hangman extends StatefulWidget {
  const Hangman({super.key});

  @override
  State<Hangman> createState() {
    return _HangmanState();
  }
}

class _HangmanState extends State<Hangman> {
  bool gameOn = false; // game has not started yet
  int gameNumber = 0;
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
      gameNumber = 0;
      currentSettings = Settings(
        difficulty: currentSettings.difficulty, 
        marathonMode: currentSettings.marathonMode
        );
    });
  }

  void resetGameCounter(){
    setState(() {
      gameNumber = 0;
    });
  }

  // to be called when user saves on Settings overlay, updates the current settings
  void updateSettings(Settings data) {
    setState(() {
      currentSettings = data;
    });
  }

  // onclick to open the credits display
  void _openCredits(double width) {
    showModalBottomSheet(
      useSafeArea:
          true, // makes sure that the overlay does not overlap with camera lens etc.
      context: context,
      // builder takes the current settings object, and the updateSettings function
      builder: (ctx) => Credits(width: width),
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

  void playGame() async {
    // if user sets a title/word, that's all we need
    if (currentSettings.customTitle != null) {
      Hint currentHint = constructHint(
          customTitle: currentSettings.customTitle,
          difficulty: currentSettings.difficulty);
      setState(() {
        gameOn = true;
        gameNumber +=1;
        gameScreenWaiting = GameScreen(
          hint: currentHint, 
          marathonMode: currentSettings.marathonMode,
          gameNumber: gameNumber,
          quitGame: quitGame, 
          restart: playGame,
          resetGameCounter: resetGameCounter);
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
        gameNumber +=1;
        gameScreenWaiting = GameScreen(
          hint: currentHint, 
          marathonMode: currentSettings.marathonMode, 
          gameNumber: gameNumber,
          quitGame: quitGame, 
          restart: playGame,
          resetGameCounter: resetGameCounter);
      });
      // otherwise we just make the call using the current difficulty
    } else {
      Hint currentHint = constructHint(
        difficulty: currentSettings.difficulty,
        movie: await getMovie(difficulty: currentSettings.difficulty));
      setState(() {
        gameOn = true;
        gameNumber +=1;
        gameScreenWaiting = GameScreen(
          hint: currentHint, 
          marathonMode: currentSettings.marathonMode, 
          gameNumber: gameNumber,
          quitGame: quitGame, 
          restart: playGame,
          resetGameCounter: resetGameCounter);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final double availableWidth = MediaQuery.of(context).size.width;

    // check if dark mode is active, we use this to display white/black starting image
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

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
              Image.asset( isDarkMode ? "assets/images/dark-hangman-start.png" : "assets/images/hangman-start.png",
                height: availableWidth > 500 ? 410 : availableWidth*0.8),
              SizedBox(width: availableWidth*0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                  onPressed: _openSettings, child: const Text("Settings")),
              ElevatedButton(onPressed: playGame, child: const Text("Play Now!")),
              ],)),
              const SizedBox(height: 15),
              Text("Difficulty setting: ${currentSettings.labels[currentSettings.difficulty]}"),
              const SizedBox(height: 5),
              currentSettings.marathonMode
              ? const Text("Playing in Marathon Mode")
              : const SizedBox.shrink(),
              const SizedBox(height: 5),
              // if there is a custom title, allow user to see it
              currentSettings.customTitle != null && currentSettings.customTitle != ""
              ? GestureDetector(
                onTap:() {
                  setState(() {
                    displayCustomTitle = !displayCustomTitle;
                  });
                },
                child: Text(
                  displayCustomTitle 
                  ? "Custom Title is set.\nPress here to hide."
                  : "Custom Title is set.\nPress here to show the title on screen.",
                  textAlign: TextAlign.center,)
                )
              : const Text("Playing with a Random Movie Title"),
              const SizedBox(height: 5),
              displayCustomTitle
              ? 
              GestureDetector(
                onTap:() {
                  setState(() {
                    displayCustomTitle = !displayCustomTitle;
                  });
                },
                child:Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFB71C1C))),
                child: Padding(padding: const EdgeInsets.all(5), child: Text(currentSettings.customTitle!,)  
                  
                )
              )
              )
              : const SizedBox.shrink(),
              // if a custom year is set, allow user to view it
              currentSettings.customYear != null
              ? GestureDetector(
                onTap:() {
                  setState(() {
                    displayCustomYear = !displayCustomYear;
                  });
                },
                child: Text(
                  displayCustomYear 
                  ? "Playing with a set Custom Year.\nPress here to hide."
                  : "Playing with a set Custom Year.\nPress here to show on screen.",
                  textAlign: TextAlign.center,
                  )
                )
              : const Text("Playing with a Random Release Year"),
              displayCustomYear
              ? GestureDetector(
                onTap:() {
                  setState(() {
                    displayCustomYear = !displayCustomYear;
                  });
                },
                child:Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFB71C1C))),
                child: Padding(
                  padding: const EdgeInsets.all(5), 
                  child: Text(currentSettings.customYear!.toString())
                )
              )
              )
              : const SizedBox.shrink(),
              
              SizedBox(width: availableWidth*0.8,
              child:Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: (){
                      _openCredits(availableWidth);
                    } ,
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
