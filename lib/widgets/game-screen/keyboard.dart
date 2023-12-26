import 'package:flutter/material.dart';
import 'package:hangman/models/qwerty_keyboard.dart';
import 'package:hangman/widgets/game-screen/keyboard_button.dart';
import 'package:hangman/models/classes.dart';


// separate stateful widget for the keyboard
class Keyboard extends StatefulWidget {
  final Function confirmGuess;
  final ResponsiveSizes titleLetterWidth;
  bool disableKeyboard;
  final int numberOfGuesses;
  final bool marathonMode;
  Keyboard({
    super.key,
    required this.confirmGuess,
    required this.titleLetterWidth,
    required this.disableKeyboard,
    required this.numberOfGuesses,
    required this.marathonMode,
    });

  @override
  State<Keyboard> createState(){
    return _KeyboardState();
  }
}

class _KeyboardState extends State<Keyboard> {
  String currentLetter = "";
  String activeButtonIndex = "";

  List<List<String>> qwertyKeyboard = generateKeyboard();


  void setActiveButton(String index){
    setState(() {
      activeButtonIndex = index;
    });
  }

  void updatePlaceholder(String letter) {
    setState(() {
      currentLetter = letter;
    });
  }

  void _onPressGo(){
    if (currentLetter.isNotEmpty){
    setState(() {
      widget.confirmGuess(currentLetter);
      for (List row in qwertyKeyboard) {
          row.remove(currentLetter);
      }
      currentLetter = "";
      activeButtonIndex = "";
    }
    );
    }
  }

  @override
  Widget build(BuildContext context) {

    // rebuild keyboard if we are starting a new game
    if (widget.numberOfGuesses == 0 && !(widget.marathonMode)){qwertyKeyboard = generateKeyboard();}

    widget.titleLetterWidth.numberOfLetters = 10;
    final keyWidth = widget.titleLetterWidth.letterWidth;
    final keyHeight = keyWidth*1.3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      
      children: [
        // loop through the keys on the keyboard-list to construct the keyboard
        for (int i = 0; i < qwertyKeyboard.length; i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              for (int a = 0; a < qwertyKeyboard[i].length; a++)
                // if we are on the last key in the list, make a custom "GUESS" key:
                (i == 2 && a == qwertyKeyboard[i].length - 1) ?
                Padding(
                    padding: EdgeInsets.all(widget.titleLetterWidth.padding),
                    child: SizedBox(
                      width: keyWidth*2,
                      height: keyHeight,
                      child: 
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 0, 
                            horizontal: 0),
                          shadowColor: Colors.redAccent,
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)
                          ),
                          ),
                        onPressed: widget.disableKeyboard ? (){} : () { _onPressGo();},
                        child: Text(qwertyKeyboard[i][a], style:const TextStyle(fontSize: 12, color: Color(0xFFFFFFFF))),
                      ),
                    ),
                )
                      // .. otherwise, make a regular letter key.
                      :
                    Padding(
                    padding: EdgeInsets.all(widget.titleLetterWidth.padding),
                    child: SizedBox(
                      width: keyWidth,
                      height: keyHeight,
                      child: KeyboardButton(
                        index: qwertyKeyboard[i][a],
                        isActive: activeButtonIndex == qwertyKeyboard[i][a],
                        setActive: setActiveButton,
                        keyboardKey: qwertyKeyboard[i][a], 
                        updatePlaceholder: updatePlaceholder,
                      )
                    ),
                    
                  ),
                
            ],
          )
      ],
    );
  }
}