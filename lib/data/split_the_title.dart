  List<List<String>> splitTheTitle({required List<String> wholeTitle, required int maxlength}){
    // if the whole thing is less than maxlength, we just wrap it in another list and return
    // we need it to be a list of lists since we plan to iterate on titles
    // less than max and more than max in the same way
    if (wholeTitle.length < maxlength){return [wholeTitle];} 

    List<String> titleWordForWord = wholeTitle.join().split(" ");
    List<List<String>> fixedTitle = [];
    // TODO -- check if the first word, and then every word, is >maxlength. if so split in two
    String titleFragment = titleWordForWord[0].toString();

    // run through the fragmented list, see if the two current words are more than the max,
    // if so, keep the current string and start a new one with the current word
    for (int i = 1; i < titleWordForWord.length; i++){
      if (titleFragment.length + titleWordForWord[i].length < maxlength){
        titleFragment = "$titleFragment ${titleWordForWord[i]}";
      } else {
        fixedTitle.add(titleFragment.split(""));
        titleFragment = titleWordForWord[i];
      }
    }
    // and then add the remaining string
    fixedTitle.add(titleFragment.split(""));
    return fixedTitle;
  }