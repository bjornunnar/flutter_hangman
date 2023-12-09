import 'package:flutter/material.dart';
import 'package:hangman/models/classes.dart';
import 'package:hangman/widgets/guess_entire_title.dart';
import 'package:hangman/widgets/keyboard.dart';
import 'package:hangman/widgets/guessed_letters_view.dart';
import 'package:hangman/data/check_guess.dart';
import 'package:hangman/data/check_winner.dart';
import 'package:hangman/data/check_loser.dart';
import 'package:hangman/widgets/current_title.dart';
import 'package:hangman/data/split_the_title.dart';
import 'package:hangman/widgets/loser_screen.dart';
import 'package:hangman/widgets/loser_screen_custom.dart';
import 'package:hangman/widgets/winner_screen.dart';
import 'package:hangman/widgets/winner_screen_custom.dart';


class GameScreen extends StatefulWidget {
  Hint hint;
  final Function quitGame;
  GameScreen({
    super.key, 
    required this.hint, 
    required this.quitGame
    });

  @override
  State<GameScreen> createState() {
    return _GameScreenState();
  }
}

class _GameScreenState extends State<GameScreen> {
  bool weHaveAWinner = false;
  bool weHaveALoser = false;
  late bool disableKeyboard = (weHaveALoser || weHaveAWinner);
  
  void confirmGuess(String letter) {
      setState(() {
        // getting the current length of the guessed letters list, to check against
        // the same list after we run through and replace
        // there should be a better way to do this..?
        int beforeGuessIsChecked = widget.hint.guessedLetters.length;
        // compare the guess with the current word, return new hint object
        widget.hint = checkGuess(letter: letter, hint: widget.hint);

        if (beforeGuessIsChecked != widget.hint.guessedLetters.length){
          // drop number of available tries by 1 and check if game is lost
          weHaveALoser = checkLoser(widget.hint);
          if (weHaveALoser){
            _loserDialog();
          }
        } else {
          // if the guess was correct, check if game is won
          weHaveAWinner = checkWinner(widget.hint);
          if (weHaveAWinner){
            _winnerDialog();
          }
        }
      });
  }

  void checkEntireTitleGuess(String title, String guess){
    if (title.toLowerCase() == guess.toLowerCase()){
      setState(() {
        weHaveAWinner = true;
        _winnerDialog();
      });
    } else {
      setState(() {
        weHaveALoser = true;
        _loserDialog();
      });
    }
  }

  void _openGuessEntireTitle() {
    showModalBottomSheet(
      useSafeArea:
        true, // makes sure that the overlay does not overlap with camera lens etc.
      isScrollControlled: true,
      context: context,
      // builder takes the hint object and a callback function
      builder: (ctx) => GuessEntireTitle(hint: widget.hint, checkEntireTitleGuess: checkEntireTitleGuess));
  }

  void _winnerDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return 
        widget.hint.movie != null ? WinnerScreen(movie: widget.hint.movie)
        : WinnerScreenCustom(customTitle: widget.hint.cleanTitle);
      },
    );
  }

  void _loserDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return 
        widget.hint.movie != null ? LoserScreen(movie: widget.hint.movie)
        : LoserScreenCustom(customTitle: widget.hint.cleanTitle);
      },
    );
  }

  void _onGiveUp(){
    setState(() {
      weHaveALoser = true;
    });
    _loserDialog();
  }

  void _onQuit() {
    widget.quitGame();
  }

  @override
  Widget build(context) {
    // how many letters we want to display on a single line.
    // this gets passed to the responsive layout as well as  the title display 
    int maxLength = 12;
    double gameScreenWidth = MediaQuery.of(context).size.width;
    ResponsiveSizes titleLetterWidth = ResponsiveSizes(availableWidth: gameScreenWidth, padding: 3, numberOfLetters: maxLength);
    double guessedLettersViewWidth = ((titleLetterWidth.letterWidth)*3)+(titleLetterWidth.padding*8);

    // roll through the hangman images based on number of guesses left
    // we only have 6 images so easy mode shows the first image for a few turns
    int hangmanImageNumber;
    widget.hint.tries >= 6 ? hangmanImageNumber = 6 : hangmanImageNumber = widget.hint.tries;
    if (weHaveALoser){hangmanImageNumber = 0;}

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Container(

                  decoration: BoxDecoration(
                    border: Border.all(),
                    image: DecorationImage(
                      image: AssetImage("assets/images/hangman0$hangmanImageNumber.png")
                    )
                  ),
                  width: 170,
                  height: 200,
                ),
                const Spacer(),
                Container(
                  width: guessedLettersViewWidth,
                  height: 200,
                  child: 
                    GuessedLettersView(
                      guessedLetters: widget.hint.guessedLetters, 
                      titleLetterWidth: titleLetterWidth,
                    ),
                ),
              ],
            ),
            // check if game is won or lost. if so, we just get the full title to display.
            // if not, we display what the user has so far
            // it's split into lines depending on the screen width and length of words
            for (List fragment in splitTheTitle(
              wholeTitle: (weHaveALoser || weHaveAWinner) 
              ? widget.hint.cleanTitleAsList 
              : widget.hint.hiddenTitleAsList, 
              maxlength: 12))
              CurrentTitle(title: fragment as List<String>, titleLetterWidth: titleLetterWidth,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _onQuit,
                  icon: const Icon(Icons.transit_enterexit),
                  label: const Text("I Quit")),
                ElevatedButton.icon(
                  onPressed: weHaveALoser == true || weHaveAWinner == true ? (){} : _onGiveUp,
                  icon: const Icon(Icons.transfer_within_a_station),
                  label: const Text("Just Tell Me")),
                
                ElevatedButton.icon(
                  onPressed: _openGuessEntireTitle,
                  icon: const Icon(Icons.explicit),
                  label: const Text("I Have It!")),
              ],
            ),
      
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Keyboard(confirmGuess: confirmGuess, titleLetterWidth: titleLetterWidth, disableKeyboard: disableKeyboard),
              ],
            )
          ],
        ),
      ),
    );
  }
}



