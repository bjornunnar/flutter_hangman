import 'package:flutter/material.dart';
import 'package:hangman/data/check_entire_title_guess.dart';
import 'package:hangman/models/classes.dart';
import 'package:hangman/widgets/game-screen/guess_entire_title.dart';
import 'package:hangman/widgets/game-screen/keyboard.dart';
import 'package:hangman/widgets/game-screen/guessed_letters_view.dart';
import 'package:hangman/data/check_guess.dart';
import 'package:hangman/data/check_winner.dart';
import 'package:hangman/data/check_loser.dart';
import 'package:hangman/widgets/game-screen/current_title.dart';
import 'package:hangman/data/split_the_title.dart';
import 'package:hangman/widgets/end-screens/loser_screen.dart';
import 'package:hangman/widgets/end-screens/loser_screen_custom.dart';
import 'package:hangman/widgets/end-screens/winner_screen.dart';
import 'package:hangman/widgets/end-screens/winner_screen_custom.dart';


class GameScreen extends StatefulWidget {
  Hint hint;
  final Function quitGame;
  final Function restart;
  GameScreen({
    super.key, 
    required this.hint, 
    required this.quitGame,
    required this.restart
    });

  @override
  State<GameScreen> createState() {
    return _GameScreenState();
  }
}

class _GameScreenState extends State<GameScreen> {
  bool weHaveAWinner = false;
  bool weHaveALoser = false;
  
  bool isGameOver(){
    return weHaveALoser || weHaveAWinner;
  }
  
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

  // Takes the user's guess from the bottom sheet input, runs through the comparison function and returns either a winner or loser
  void checkTitleCallback(String title, String guess){
    if (checkEntireTitleGuess(title, guess)){
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
      builder: (ctx) => GuessEntireTitle(hint: widget.hint, checkTitle: checkTitleCallback));
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

  void _onRestart(){
    setState(() {
      weHaveALoser = false;
      weHaveAWinner = false;
      widget.restart();
    });
  }

  void _onQuit() {
    widget.quitGame();
  }

  // roll through the hangman images based on number of guesses left
  // we only have 7 images so easy mode shows the first image for a few turns
  int hangmanImageNumber(int tries){
    if (weHaveALoser){
      return 0;
    } else if (weHaveAWinner){
      return 6;
    } else if (tries >= 6){
      return 6;
    } else {
      return tries;
    }
  }

  @override
  Widget build(context) {
    // how many letters we want to display on a single line.
    // this gets passed to the responsive layout as well as  the title display 
    int maxLength = 12;
    double gameScreenWidth = MediaQuery.of(context).size.width;
    ResponsiveSizes titleLetterWidth = ResponsiveSizes(availableWidth: gameScreenWidth, padding: 3, numberOfLetters: maxLength);
    // we want the guessed letters' width to match the title letters' width, so we pass this on to the guessed letters view widget
    double guessedLettersViewWidth = ((titleLetterWidth.letterWidth)*3)+(titleLetterWidth.padding*8);

    // check if dark mode is active, we use this to display white/black progress images
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    // onscreen message
    final String onScreenMessage;
    if (weHaveALoser){onScreenMessage = "You Lost!";}
    else if (weHaveAWinner){onScreenMessage = "You Won!";}
    else {onScreenMessage = "Guess the Title!";}

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: isDarkMode
                          ? AssetImage("assets/images/dark-hangman0${hangmanImageNumber(widget.hint.tries)}.png")
                          : AssetImage("assets/images/hangman0${hangmanImageNumber(widget.hint.tries)}.png"),
                        )
                      ),
                      width: 170,
                      height: 200,
                    ),
                    // count down no of fails available to the player
                    // if at 0 or game is lost, don't show anything
                    widget.hint.tries < 1 || isGameOver()
                    ? const SizedBox.shrink()
                    : widget.hint.tries == 1
                    ? const Text("Last Chance!")
                    : Text("${widget.hint.tries} fails left"),
                  ],
                ),
                const Spacer(),

                // only display the guessed letters bin after the first fail
                widget.hint.guessedLetters.isNotEmpty
                ? Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    const Column(
                      children: [
                        Text("Guessed\nLetters", textAlign: TextAlign.center,),
                        Icon(Icons.keyboard_arrow_down_rounded)
                      ],
                    ),
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
                )
                : const SizedBox.shrink(),
              ],
            ),
            Text(onScreenMessage,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,),
            // check if game is won or lost. if so, we just get the full title to display.
            // if not, we display what the user has so far
            // it's split into lines depending on the screen width and length of words
            for (List fragment in splitTheTitle(
              wholeTitle: (isGameOver()) 
              ? widget.hint.cleanTitleAsList 
              : widget.hint.hiddenTitleAsList, 
              maxlength: maxLength))
              CurrentTitle(title: fragment as List<String>, titleLetterWidth: titleLetterWidth,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.backspace_outlined, size: 16),
                  onPressed: _onQuit,
                  label: const Text("I Quit",)), 
                if (!isGameOver())
                ElevatedButton.icon(
                  onPressed: _onGiveUp,
                  icon: const Icon(Icons.question_answer_outlined, size: 16,),
                  label: const Text("Tell Me")),
                if (!isGameOver())
                ElevatedButton.icon(
                  onPressed: _openGuessEntireTitle,
                  icon: const Icon(Icons.expand_circle_down_outlined, size: 16),
                  label: const Text("I Have It!")),
                if (isGameOver())
                ElevatedButton.icon(
                  onPressed: _onRestart,
                  icon: const Icon(Icons.replay_circle_filled_rounded, size: 16),
                  label: const Text("Go Again!")),
              ],
            ),
      
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Keyboard(
                  confirmGuess: confirmGuess, 
                  titleLetterWidth: titleLetterWidth, 
                  disableKeyboard: isGameOver()
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}



