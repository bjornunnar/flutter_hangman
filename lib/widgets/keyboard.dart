import 'package:flutter/material.dart';
import 'package:hangman/models/qwerty_keyboard.dart';
import 'package:hangman/widgets/keyboard_button.dart';
import 'package:hangman/models/classes.dart';


// separate stateful widget for the keyboard
class Keyboard extends StatefulWidget {
  final Function confirmGuess;
  final ResponsiveSizes titleLetterWidth;
  const Keyboard({
    super.key,
    required this.confirmGuess,
    required this.titleLetterWidth});

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
    }
    );
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.titleLetterWidth.numberOfLetters = 10;
    final keyWidth = widget.titleLetterWidth.letterWidth;
    // final availableWidth = MediaQuery.of(context).size.width;
    // const double padding = 3.0;
    // final keyWidth = (availableWidth-(padding*2*10))/11;
    final keyHeight = keyWidth;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      
      children: [
        // loop through the keys on the keyboard-list to construct the keyboard
        for (int i = 0; i < qwertyKeyboard.length; i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              for (int a = 0; a < qwertyKeyboard[i].length; a++)
                // if we are on the last key in the list, make a custom "GO" key:
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
                        onPressed: () {
                          _onPressGo();
                        },
                        child: Text(qwertyKeyboard[i][a], style:const TextStyle(fontSize: 12)),
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