import 'package:flutter/material.dart';
import 'package:hangman/models/classes.dart';
import 'package:hangman/data/split_the_title.dart';
import 'package:hangman/widgets/current_title.dart';

class GuessEntireTitle extends StatefulWidget {
  Hint hint;
  bool weHaveALoser;
  bool weHaveAWinner;
  GuessEntireTitle({
    super.key, 
    required this.hint,
    required this.weHaveALoser,
    required this.weHaveAWinner,
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

  void checkEntireTitleGuess(Hint hint, String guess){
    if (hint.cleanTitle.toLowerCase() == guess.toLowerCase()){
      setState(() {
        widget.weHaveAWinner = true;
      });
    } else {
      setState(() {
        widget.weHaveALoser = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    int maxLength = 12;
    double gameScreenWidth = MediaQuery.of(context).size.width;
    ResponsiveSizes titleLetterWidth = ResponsiveSizes(availableWidth: gameScreenWidth, padding: 3, numberOfLetters: maxLength);

    return AlertDialog(
      title: const Text('You Lose', textAlign: TextAlign.center,),
      content: Column(
        children: [
          for (List fragment in splitTheTitle(wholeTitle: widget.hint.hiddenTitleAsList, maxlength: maxLength))
              CurrentTitle(title: fragment as List<String>, titleLetterWidth: titleLetterWidth,),
          const Text("Input your guess.",textAlign: TextAlign.center,),
          Expanded(
          child: TextField(
            autofocus: true,
            textCapitalization: TextCapitalization.characters,
            enabled: true,
            autocorrect: false,
            controller: _titleGuess,
            maxLength: 40,
            decoration: const InputDecoration(
                label: Text("..and write it down")),
          ),
        ),
        ],
      ),
      
      actions: <Widget>[
        ElevatedButton(
          child: const Text('Nevermind'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: const Text('Confirm Guess'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}