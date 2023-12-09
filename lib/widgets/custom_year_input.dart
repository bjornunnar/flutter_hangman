import 'package:flutter/material.dart';

class CustomYearSetting extends StatefulWidget {
  final bool yearIsChecked;
  final TextEditingController yearController;
  final void Function() enableCustomYear;
  const CustomYearSetting({
    super.key, 
    required this.yearController,
    required this.yearIsChecked,
    required this.enableCustomYear
    });

  

  @override
  State<CustomYearSetting> createState() => _CustomYearSettingState();
}

class _CustomYearSettingState extends State<CustomYearSetting> {


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
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: widget.yearIsChecked,
          onChanged: (bool? value) {
            setState(() {
              if (value != null){
              widget.enableCustomYear();
              }
            });
          },
        ),
        Expanded(
          child: TextField(
            autofocus: widget.yearIsChecked,
            enabled: widget.yearIsChecked,
            keyboardType: TextInputType.number,
            controller: widget.yearController,
            maxLength: 4,
            decoration: const InputDecoration(
                label: Text(
                    "(Must be between 1920 and 2023)")
            ),
          ),
        ),
      ],
    );
  }
}
