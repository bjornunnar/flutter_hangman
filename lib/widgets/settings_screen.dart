import 'package:flutter/material.dart';
import 'package:hangman/models/classes.dart';
// import 'package:hangman/widgets/custom_title_input.dart';
// import 'package:hangman/widgets/custom_year_input.dart';

class SettingsOverlay extends StatefulWidget {
  const SettingsOverlay(
      {super.key, required this.currentSettings, required this.updateSettings});

  // callback function to update current settings when the overlay is "saved"
  final void Function(Settings data) updateSettings;
  final Settings currentSettings;

  @override
  State<SettingsOverlay> createState() {
    return _SettingsOverlayState();
  }
}

class _SettingsOverlayState extends State<SettingsOverlay> {
  bool titleIsChecked = false;
  bool yearIsChecked = false;
  // previously saved title or year is set again:
  late final _titleController = TextEditingController(
    text: widget.currentSettings.customTitle
    );
  late final _yearController = TextEditingController(text: 
    widget.currentSettings.customYear != null 
    ? widget.currentSettings.customYear.toString()
    : "",
    );
  late double sliderDifficultySetting =
      (widget.currentSettings.difficulty).toDouble();

  // tells flutter to shut down the TextEditingController when the overlay is closed
  // otherwise it lives on in memory
  @override
  void dispose() {
    _titleController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  // updates the value of the difficulty slider.
  void sliderUpdate(double value) {
    setState(() {
      sliderDifficultySetting = value;
    });
  }

  void enableCustomYear(){
    setState(() {
      yearIsChecked = !yearIsChecked;
      if (yearIsChecked) {titleIsChecked = false;}
      _titleController.text = "";
      print("enabling custom year");
      
    });
  }
  void enableCustomTitle(){
    setState(() {
      titleIsChecked = !titleIsChecked;
      if (titleIsChecked){yearIsChecked = false;}
      _yearController.text = "";
      print("enabling custom title");
    });
  }

  void _onSaveSettings() {
    // logic to save current inputs
    // check if the input fields are empty first, if so we don't include them.
    int newDifficulty = sliderDifficultySetting.floor();
    Settings newSettings = Settings(difficulty: newDifficulty);
    if (_titleController.text.isNotEmpty) {
      newSettings.customTitle = _titleController.text;
    }
    if (_yearController.text.isNotEmpty) {
      int? newYear = int.tryParse(_yearController.text);
      if (newYear == null || newYear > 1919 && newYear < 2024) {
        newSettings.customYear = newYear;
      } else {
        _showDialog();
        return;
      }
    }
    setState(() {
      widget.updateSettings(newSettings);
    });
    // and pop context!
    Navigator.pop(context);
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Quick, what year is it?!"),
        content: const Text(
          "The chosen year must be between 1920 and 2023. I make the rules."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text("FINE"))
          ],
        )
    );
  }

  @override
  Widget build(context) {

    // get the text labels for the difficulty settings, and set style for headers
    List difficultyLabelsList = widget.currentSettings.labels.values.toList();
    const textHeaders = TextStyle(fontSize: 18,fontWeight: FontWeight.bold,);

    // checking if user already saved custom settings, and enabling those already
    if (widget.currentSettings.customTitle != null){titleIsChecked = true;}
    if (widget.currentSettings.customYear != null){yearIsChecked = true;}

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Difficulty",
            style: textHeaders),
          Slider(
              value: sliderDifficultySetting,
              label: widget.currentSettings.labels[sliderDifficultySetting],
              min: 1,
              max: 5,
              divisions: 4,
              onChanged: (double newValue) {
                sliderUpdate(newValue);
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 1; i <= 5; i++)
                Text(
                  '${difficultyLabelsList[i-1]}', // Display the difficulty settings
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: sliderDifficultySetting == i.toDouble()
                        ? Colors.blue // Highlight the selected value
                        : Colors.black,
                  ),
                ),
              ],
            ),
          const SizedBox(height: 50,),
          const Text("The options below are.. optional."),
          const Text("You can choose a title to play with, or the movie release year you would like to play."),
          const Text("Note that you can only have one or the other!", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          const Text("Pick the Title",
          style: textHeaders,), 
          Row(
              children: [
                Checkbox(
                  value: (titleIsChecked),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value != null && value){
                        enableCustomTitle();
                      }
                    });
                  },
                ),
                Expanded(
                  child: TextField(
                    enabled: titleIsChecked,
                    autocorrect: false,
                    controller: _titleController,
                    maxLength: 40,
                    decoration: const InputDecoration(
                        label: Text("..and write it down")),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
          const Text("Pick the Year",
          style: textHeaders),
          Row(
            children: [
              Checkbox(
                  value: yearIsChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      if (value != null && value){
                      enableCustomYear();
                      }
                    });
                  },
                ),
              Expanded(
                child: TextField(
                  enabled: yearIsChecked,
                  keyboardType: TextInputType.number,
                  controller: _yearController,
                  maxLength: 4,
                  decoration: const InputDecoration(
                      label: Text(
                          "(Must be between 1920 and 2023)")
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                        context); // closes the overlay by 'popping' the context given to the current build method
                  },
                  child: const Text("Nevermind")),
              ElevatedButton(
                  onPressed: _onSaveSettings,
                  child: const Text("Save Settings")),
            ],
          )
        ],
      ),
    );
  }
}
