import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;

class RadioButon extends StatefulWidget {
  final String valueRadio;
  String group;
  String? description;
  IconData? icon;
  final void Function(String)? callback;

  RadioButon({
    super.key,
    required this.valueRadio,
    required this.group,
    this.icon,
    this.description,
    this.callback,
  });

  @override
  State<RadioButon> createState() => _RadioButonState();
}

class _RadioButonState extends State<RadioButon> {

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        radioTheme: RadioThemeData(
          fillColor: MaterialStateColor.resolveWith((states) => globals.primaryBlack),
        )
      ),
      child: RadioListTile(
        value: widget.valueRadio,
        groupValue: widget.group,
        onChanged: (value) => {
          setState(() {
            widget.group = value!;
          }),
        },
        
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            (widget.icon != null) ?
              Row(
                children: [
                  Icon(
                    widget.icon,
                    color: globals.primary,
                  ),

                  const SizedBox(width: 10),

                  Text(
                    widget.valueRadio,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ],
              ) : Text(
                widget.valueRadio,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            

            (widget.callback != null) ?
              IconButton(
                onPressed: () {
                  setState(() {
                    widget.group = 'Edit-Casa';
                  });

                  widget.callback!(widget.group);
                },
                icon: const Icon(Icons.edit),
                color: globals.primary,
              ) : const SizedBox(),
          ],
        ),

        
        subtitle: widget.description != null ? Text(
          widget.description!,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black54,
          ),
        ) : null,


      ),
    );
  }
}