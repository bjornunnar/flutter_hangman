import 'package:flutter/material.dart';
import 'package:hangman/models/classes.dart';
import 'package:hangman/data/split_the_title.dart';
import 'package:hangman/widgets/game-screen/current_title.dart';

class GuessEntireTitle extends StatefulWidget {
  Hint hint;
  final Function checkTitle;
  GuessEntireTitle({
    super.key, 
    required this.hint,
    required this.checkTitle,
    });
  

  @override
  State<GuessEntireTitle> createState() {
    return _GuessEntireTitleState();
  }
}
class _GuessEntireTitleState extends State<GuessEntireTitle> {

final _titleGuess = TextEditingController();
  @override
  void dispose() {
    _titleGuess.dispose();
    super.dispose();
  }

// display all characters in the text input field as capitalized
@override
  void initState() {
    super.initState();
    _titleGuess.addListener(() {
      final text = _titleGuess.text;
      _titleGuess.value = _titleGuess.value.copyWith(
        text: text.toUpperCase(), // Force uppercase for the text
      );
    });
  }



  @override
  Widget build(BuildContext context) {

    int maxLength = 12;
    double gameScreenWidth = MediaQuery.of(context).size.width-100;
    ResponsiveSizes titleLetterWidth = ResponsiveSizes(availableWidth: gameScreenWidth, padding: 3, numberOfLetters: maxLength);

    return AlertDialog(
      title: const Text('All or Nothing!', textAlign: TextAlign.center,),
      content: Column(
        children: [
          for (List fragment in splitTheTitle(wholeTitle: widget.hint.hiddenTitleAsList, maxlength: maxLength))
              CurrentTitle(title: fragment as List<String>, titleLetterWidth: titleLetterWidth,),
          const SizedBox(height: 30),
          const Text("Input your guess. If you're wrong, you lose.",textAlign: TextAlign.center,),
          
          Expanded(
          child: TextField(
            maxLines: 2,
            minLines: 2,
            autofocus: true,
            textCapitalization: TextCapitalization.characters,
            enabled: true,
            autocorrect: false,
            controller: _titleGuess,
          ),
        ),
        ],
      ),
      
      actions: <Widget>[
        Row(
        children: [
          ElevatedButton(
          child: const Text('Nevermind'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        const Spacer(),
        ElevatedButton(
          child: const Text('Confirm Guess'),
          onPressed: () {
            Navigator.of(context).pop();
            widget.checkTitle(widget.hint.cleanTitle, _titleGuess.text);
          },
        ),
        ],
        ),
      ],
    );
  }
}