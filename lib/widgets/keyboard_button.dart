import 'package:flutter/material.dart';

// separate stateful widget for each letter button..
class KeyboardButton extends StatefulWidget {
  final String index;
  final bool isActive;
  final Function setActive;
  final Function updatePlaceholder;
  final String keyboardKey;
  const KeyboardButton({
    super.key, 
    required this.index,
    required this.isActive,
    required this.setActive,
    required this.keyboardKey, 
    required this.updatePlaceholder});

  @override
  State<KeyboardButton> createState(){
    return _KeyboardButtonState();
  }
}

class _KeyboardButtonState extends State<KeyboardButton> {
  final Color passiveColor = Colors.blue;
  final Color passiveColorShadow = Colors.blueAccent;
  final Color activeColor = Colors.red;
  final Color activeColorShadow = Colors.redAccent;

  void _onButtonPress(){
    setState(() {
      widget.updatePlaceholder(widget.keyboardKey);
      widget.setActive(widget.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 0),
        shadowColor: widget.isActive ? activeColorShadow : passiveColorShadow,
        backgroundColor: widget.isActive ? activeColor : passiveColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
        ),
      ),
      onPressed: () {
        _onButtonPress();        
      },
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          widget.keyboardKey,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}