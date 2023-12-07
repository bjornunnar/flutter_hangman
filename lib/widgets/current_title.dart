import 'package:flutter/material.dart';
import 'package:hangman/models/classes.dart';

class CurrentTitle extends StatelessWidget{
  final List<String> title;
  final ResponsiveSizes titleLetterWidth;
  const CurrentTitle({
    super.key, 
    required this.title, 
    required this.titleLetterWidth
    });


  @override
  Widget build(context){

    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (String letter in title)
          (letter != "_" && letter != " ") 
          ?  
          Padding(
            padding: EdgeInsets.all(titleLetterWidth.padding),
              child: Container(
                width: titleLetterWidth.letterWidth,
                height: titleLetterWidth.letterWidth,
                decoration: const BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.blueAccent, blurRadius: 1, offset: Offset(1, 1))],
                  borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                  color: Colors.blue), 
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        letter, 
                        style: const TextStyle(
                          color: Colors.white, 
                          fontWeight: FontWeight.bold, 
                          fontSize: 16)
                          ),
                    )
                        )
              ),
          )
          : 
          Padding(
            padding: EdgeInsets.all(titleLetterWidth.padding),
            child: 
              (letter == " ") ?
              SizedBox(
                width: titleLetterWidth.letterWidth,
                height: titleLetterWidth.letterWidth,)
              :
              Container(
                width: titleLetterWidth.letterWidth,
                height: titleLetterWidth.letterWidth,
                decoration: const BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.blueAccent, blurRadius: 1, offset: Offset(1, 1))],
                  borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                  color: Colors.blue),
              ),
          )
          
    
        ],
    );
  }
}