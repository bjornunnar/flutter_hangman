import 'package:flutter/material.dart';

class CurrentTitle extends StatelessWidget{
  final List<String> title;
  const CurrentTitle({super.key, required this.title});


  @override
  Widget build(context){
    final availableWidth = MediaQuery.of(context).size.width;
    const double padding = 3.0;
    final letterWidth = (availableWidth-(padding*2*12))/13;

    return Container(
      alignment: Alignment.center,
      child: Row(
        children: [
          for (String letter in title)
          (letter != "_" && letter != " ") 
          ?  
          Padding(
            padding: const EdgeInsets.all(padding),
              child: Container(
                width: letterWidth,
                height: letterWidth,
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
            padding: const EdgeInsets.all(padding),
            child: 
              (letter == " ") ?
              SizedBox(
                width: letterWidth,
                height: letterWidth,)
              :
              Container(
                width: letterWidth,
                height: letterWidth,
                decoration: const BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.blueAccent, blurRadius: 1, offset: Offset(1, 1))],
                  borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                  color: Colors.blue),
              ),
          )
          
    
        ],
      ),
    );
  }
}