import 'package:flutter/material.dart';

class CustomYearSetting extends StatefulWidget {
  final bool disabled;
  const CustomYearSetting({super.key, this.disabled = false, required this.enableCustomYear});

  final void Function() enableCustomYear;

  @override
  State<CustomYearSetting> createState() => _CustomYearSettingState();
}

class _CustomYearSettingState extends State<CustomYearSetting> {
  bool isChecked = false;

  _onChecked(){
    setState(() {
      isChecked = !isChecked;
      widget.enableCustomYear;
    });
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
        Checkbox(
          isError: widget.disabled,
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked,
          onChanged: _onChecked(),
        ),
      ],
    );
  }
}
