import 'package:flutter/material.dart';
import 'package:hangman/models/classes.dart';
import 'package:hangman/widgets/custom_title_input.dart';
import 'package:hangman/widgets/custom_year_input.dart';

class SettingsOverlay extends StatefulWidget {
  SettingsOverlay({
      super.key, 
      required this.currentSettings, 
      required this.updateSettings
      });

  // callback function to update current settings when the overlay is "saved"
  final void Function(Settings data) updateSettings;
  final Settings currentSettings;

  // both custom settings are disabled by default
  bool titleIsChecked = false;
  bool yearIsChecked = false;

  @override
  State<SettingsOverlay> createState() {
    return _SettingsOverlayState();
  }
}

class _SettingsOverlayState extends State<SettingsOverlay> {

  // previously saved title or year is set again:
  late final titleController = TextEditingController(
    text: widget.currentSettings.customTitle 
    ?? widget.currentSettings.customTitle,
    );
  late final yearController = TextEditingController(
    text: widget.currentSettings.customYear != null 
    ? widget.currentSettings.customYear.toString()
    : "",
    );
  late double sliderDifficultySetting =
      (widget.currentSettings.difficulty).toDouble();

  // tells flutter to shut down the TextEditingController when the overlay is closed
  // otherwise it lives on in memory
  @override
  void dispose() {
    titleController.dispose();
    yearController.dispose();
    super.dispose();
  }

  // updates the value of the difficulty slider.
  void sliderUpdate(double value) {
    setState(() {
      sliderDifficultySetting = value;
    });
  }

    // toggles the Custom Title / Custom Year options,
    // disables one when the other is enabled,
    // and wipes the textfields and saved settings if the option is un-selected
    // this DOES erase the current settings without the user selecting SAVE..
    void enableCustomTitle(){
    setState(() {
      widget.titleIsChecked = !widget.titleIsChecked;
      if (!widget.titleIsChecked){
        titleController.text = "";
        widget.currentSettings.customTitle = "";
        }
      if (widget.titleIsChecked){
        widget.yearIsChecked = false;
        yearController.text = "";
        widget.currentSettings.customYear = null;
        }
      print("enabling custom title");
    });
  }
  void enableCustomYear(){
    setState(() {
      widget.yearIsChecked = !widget.yearIsChecked;
      if (!widget.yearIsChecked){
        yearController.text = "";
        widget.currentSettings.customYear = null;
        }
      if (widget.yearIsChecked) {
        widget.titleIsChecked = false;
        titleController.text = "";
        widget.currentSettings.customTitle = "";
        }
      
      print("enabling custom year");
      
    });
  }

  void _onSaveSettings() {
    // logic to save current inputs
    // check if the input fields are empty first, if so we don't include them.
    int newDifficulty = sliderDifficultySetting.floor();
    Settings newSettings = Settings(difficulty: newDifficulty);
    if (titleController.text.isNotEmpty) {
      newSettings.customTitle = titleController.text;
    }
    if (yearController.text.isNotEmpty) {
      int? newYear = int.tryParse(yearController.text);
      if (newYear == null || newYear < 1919 || newYear > 2024) {
        _showErrorDialog();
        yearController.text = "";
        return;
      } else {
        newSettings.customYear = newYear;
      }
    }
    setState(() {
      widget.updateSettings(newSettings);
    });
    // and pop context!
    Navigator.pop(context);
  }

  // 
  void _showErrorDialog() {
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
    List difficultyLabelsList = widget.currentSettings.difficultyLabels;
    const textHeaders = TextStyle(fontSize: 18,fontWeight: FontWeight.bold,);

    // checking if user already saved custom settings, and enabling those already
    if (widget.currentSettings.customTitle != "" && widget.currentSettings.customTitle != null){widget.titleIsChecked = true;}
    if (widget.currentSettings.customYear != null){widget.yearIsChecked = true;}

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
          CustomTitleSetting(titleController: titleController, titleIsChecked: widget.titleIsChecked, enableCustomTitle: enableCustomTitle),
            const SizedBox(height: 50),
          const Text("Pick the Year",
          style: textHeaders),
          CustomYearSetting(yearController: yearController, yearIsChecked: widget.yearIsChecked, enableCustomYear: enableCustomYear),
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
