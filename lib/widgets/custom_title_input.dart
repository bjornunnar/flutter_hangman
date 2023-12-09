import 'package:flutter/material.dart';

class CustomTitleSetting extends StatefulWidget {
  final bool titleIsChecked;
  final TextEditingController titleController;
  final void Function() enableCustomTitle;
  const CustomTitleSetting({
    super.key, 
    required this.titleController,
    required this.titleIsChecked, 
    required this.enableCustomTitle
    });

  

  @override
  State<CustomTitleSetting> createState() => _CustomTitleSettingState();
}

class _CustomTitleSettingState extends State<CustomTitleSetting> {


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
          value: widget.titleIsChecked,
          onChanged: (bool? value) {
            setState(() {
              if (value != null){
                widget.enableCustomTitle();
              }
            });
          },
        ),
        Expanded(
          child: TextField(
            autofocus: widget.titleIsChecked,
            textCapitalization: TextCapitalization.characters,
            enabled: widget.titleIsChecked,
            autocorrect: false,
            controller: widget.titleController,
            maxLength: 40,
            decoration: const InputDecoration(
                label: Text("..and write it down")),
          ),
        ),
      ],
    );
  }
}
