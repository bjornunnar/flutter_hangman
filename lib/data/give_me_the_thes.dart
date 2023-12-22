// Checks if the title contains any "THE"s and replaces the spaces
// in the hidden title with the word. This makes it so that guessing
// T, H or E is less of a gimme.
String giveMeTheThes(String cleanTitle, String hiddenTitle){
  if (cleanTitle.substring(0,3) == "THE"){
  hiddenTitle = hiddenTitle.replaceRange(0, 3, "THE");
  }
  if (cleanTitle.contains(" THE ")){
    int location = cleanTitle.indexOf(" THE ");
    while (true){
    hiddenTitle = hiddenTitle.replaceRange(location, location+5, " THE ");
    if (cleanTitle.lastIndexOf(" THE ") == location){
      break;
    } else {
      location +=5;
    }
    }
  }
  
  return hiddenTitle;
}