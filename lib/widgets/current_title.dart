import 'package:flutter/material.dart';

class CurrentTitle extends StatelessWidget{
  final List<String> title;
  const CurrentTitle({super.key, required this.title});

  @override
  Widget build(context){
    return Row(
      children: [
        for (String letter in title)
        (letter != "_" && letter != " ") 
        ?  
        Padding(
          padding: const EdgeInsets.all(3.0),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                color: Colors.blue), 
                child: Center(
                  child: Text(letter, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))
            ),
        )
        : 
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: 
            (letter == " ") ?
            Container(
              width: 40,
              height: 40,)
            :
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                color: Colors.blue),
            ),
        )
        

      ],
    );
  }
}