import 'package:flutter/material.dart';
import 'package:hangman/models/classes.dart';

class SettingsOverlay extends StatefulWidget {
  SettingsOverlay({super.key,required this.currentSettings, required this.updateSettings});
  
  // callback function to update current settings when the overlay is "saved"
  final void Function(Settings data) updateSettings;
  final Settings currentSettings;


  @override
  State<SettingsOverlay> createState() {
    return _SettingsOverlayState();
  }
}

class _SettingsOverlayState extends State<SettingsOverlay> {
  final _titleController = TextEditingController();
  final _yearController = TextEditingController();
  late double sliderDifficultySetting = widget.currentSettings.difficulty;

  // tells flutter to shut down the TextEditingController when the overlay is closed
  // otherwise it lives on in memory
  @override
  void dispose(){
    _titleController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  

  // updates the value of the difficulty slider.
  void sliderUpdate(double value){
    setState(() {
      sliderDifficultySetting = value;
    });
  }

  void _onSaveSettings(){
    // logic to save current inputs
    // check if the input fields are empty first, if so we don't include them.
    double newDifficulty = sliderDifficultySetting;
    Settings newSettings = Settings(difficulty: newDifficulty);
    if (_titleController.text.isNotEmpty){
      newSettings.customTitle = _titleController.text;
    }
    if (_yearController.text.isNotEmpty){
      int? newYear = int.tryParse(_yearController.text);
      if (newYear! > 1919 && newYear < 2024){
        newSettings.customYear = newYear;
      } else {
        // open error dialog, and then return?
      }
    }
    setState(() {
      widget.updateSettings(newSettings);
    });
    // and pop context!
    Navigator.pop(context);
  }
  
  @override
  Widget build(context) {
    

    return Column(children: [
      Text("Difficulty"),
      Slider(
        value: sliderDifficultySetting, 
        min: 1, 
        max: 5, 
        divisions: 4, 
        onChanged: (double newValue){sliderUpdate(newValue);}
      ),
      Text("Choose a Title"),
      Expanded(
        child: TextField(
          controller: _titleController,
          maxLength: 50,
          decoration:
            const InputDecoration(label: Text("Input your own movie title to play with.")),
        ),
      ),
      Text("Pick the Year"),
      Expanded(
        child: TextField(
          controller: _yearController,
          maxLength: 4,
          decoration:
            const InputDecoration(label: Text("Get a movie from a year of your choice. Pick a number from 1920-2023.")),
        ),
      ),
      Row(
        children: [
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(
                context); // closes the overlay by 'popping' the context given to the current build method
            },
            child: const Text("Nevermind")),
          const Spacer(),
          ElevatedButton(
            onPressed: _onSaveSettings,
            child: const Text("Save Custom Settings")),
        ],
      )
    ],);
  }
}