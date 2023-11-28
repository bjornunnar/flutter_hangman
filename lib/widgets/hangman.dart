import 'package:flutter/material.dart';
import 'package:hangman/data/movie_details.dart';
import 'package:hangman/models/classes.dart';
import 'package:hangman/widgets/game_screen.dart';
import 'package:hangman/widgets/settings_screen.dart';


class Hangman extends StatefulWidget {
  const Hangman({super.key});

  @override
  State<Hangman> createState() {
  return _HangmanState();
  }
}
class _HangmanState extends State<Hangman>{
  String activeScreen = "start-screen";
  Settings currentSettings = Settings(difficulty: 3); // default settings w/ medium difficulty

  // to be called when user saves on Settings overlay, updates the current settings
  void updateSettings(Settings data) {
  setState(() {
    currentSettings = data;
  });
}
  // onClick to open the settings overlay. Takes as argument the current Settings
  void _openSettings(){
    showModalBottomSheet(
      useSafeArea: true, // makes sure that the overlay does not overlap with camera lens etc.
      isScrollControlled: true,
      context: context,
      // builder takes the current settings object, and the updateSettings function
      builder: (ctx) => SettingsOverlay(currentSettings: currentSettings, updateSettings: updateSettings));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          children: [
            TextButton(onPressed: _openSettings, child: const Text("Settings")),
            Text("${currentSettings.difficulty}"),
            Text("${currentSettings.customTitle}"),
            Text("${currentSettings.customYear}"),
          ],
        ),
      ),
    );
  }
}