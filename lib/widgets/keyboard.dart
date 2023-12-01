import 'package:flutter/material.dart';
import 'package:hangman/models/qwerty_keyboard.dart';
import 'package:hangman/widgets/keyboard_button.dart';


// separate stateful widget for the keyboard
class Keyboard extends StatefulWidget {
  final Function confirmGuess;
  const Keyboard({
    super.key,
    required this.confirmGuess,});

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
    return Column(
      children: [
        // loop through the keys on the keyboard-list to construct the keyboard
        for (int i = 0; i < qwertyKeyboard.length; i++)
          Row(
            children: [
              for (int a = 0; a < qwertyKeyboard[i].length; a++)
                // if we are on the last key in the list, make a custom "GO" key:
                (i == 2 && a == qwertyKeyboard[i].length - 1) ?
                Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: SizedBox(
                      width: 40,
                      height: 20,
                      child: 
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 0, 
                            horizontal: 0),
                          shadowColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)
                          ),
                          ),
                        onPressed: () {
                          _onPressGo();
                        },
                        child: const Text("GO", style:TextStyle(fontSize: 10)),
                      ),
                    ),
                )
                      // .. otherwise, make a regular letter key.
                      :
                    Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: SizedBox(
                      width: 20,
                      height: 20,
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