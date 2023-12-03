  List splitTheTitle({required List wholeTitle, required int maxlength}){
    List fixedTitle = [];
    while (wholeTitle.length > maxlength){
      int breakpoint = findBreakPoints(wholeTitle, maxlength);
      fixedTitle.add(wholeTitle.getRange(0, breakpoint));
      wholeTitle.removeRange(0, breakpoint);
    }
    if (fixedTitle.isNotEmpty){
      print("fixedtitle is not empty");
      fixedTitle.add(wholeTitle);
      return fixedTitle;
    }
    return wholeTitle;
  }

  void main(){
    String title = "Once upon a time in Hollywood";
    List titleList = title.split("");
    print(titleList);
    titleList = splitTheTitle(wholeTitle: titleList, maxlength: 12);
    print(titleList);
  }

  int findBreakPoints(List wholeTitle, int maxlength){
    if (wholeTitle.length > maxlength){
      for (int i = maxlength; i > 0; i--){
        if (wholeTitle[i] == " "){
          return i;
        }
      }
    }
    return maxlength;
  }

  // TODO -- NOT WORKING YET!!!