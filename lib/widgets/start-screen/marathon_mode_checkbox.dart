import 'package:flutter/material.dart';

class MarathonModeCheckbox extends StatefulWidget {
  final bool marathonMode;
  final Function toggleMarathonMode;
  const MarathonModeCheckbox({
    super.key, 
    required this.marathonMode,
    required this.toggleMarathonMode,
    });

  @override
  State<MarathonModeCheckbox> createState() => _MarathonModeCheckboxState();
}

class _MarathonModeCheckboxState extends State<MarathonModeCheckbox> {

bool isMarathonModeChecked(){
  if (widget.marathonMode){
    return true;
  } else {
    return false;
  }
}



  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
        MaterialState.selected,
      };
      const Set<MaterialState> nonInteractiveStates = <MaterialState>{
        MaterialState.disabled,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      if (states.any(nonInteractiveStates.contains)){
        return Colors.grey;
      }
      return Colors.white;
    }

    return Row(
      children: [
        const Expanded(
          child: Text("Enable Marathon Mode"),
        ),
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: widget.marathonMode,
          onChanged: (bool? value) {
            setState(() {
              if (value != null){
                widget.toggleMarathonMode(value);
              }
            });
          },
        ),
        
      ],
    );
  }
}
