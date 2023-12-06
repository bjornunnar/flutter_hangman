import 'package:flutter/material.dart';

class CustomTitleSetting extends StatefulWidget {
  final bool disabled;
  const CustomTitleSetting({super.key, this.disabled = false, required this.enableCustomTitle});

  final void Function() enableCustomTitle;

  @override
  State<CustomTitleSetting> createState() => _CustomTitleSettingState();
}

class _CustomTitleSettingState extends State<CustomTitleSetting> {
  bool isChecked = false;

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
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
              widget.enableCustomTitle;
            });
          },
        ),
      ],
    );
  }
}
