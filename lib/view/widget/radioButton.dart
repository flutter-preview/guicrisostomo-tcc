import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/model/standardRadioButton.dart';
import 'package:tcc/view/widget/snackBars.dart';

class RadioButon extends StatefulWidget {
  List<RadioButtonList> list;
  void Function(String?)? callback;

  RadioButon({
    super.key,
    required this.list,
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

      child: Column(
        children: widget.list.map((e) {
        
          return RadioListTile(
            value: e.name,
            groupValue: RadioButtonList.getGroup(),

            onChanged: (String? value) => {
              setState(() {
                RadioButtonList.setGroup(value!);
              }),

              if (e.callback != null) {
                e.callback!(value!)
              }
            },
            
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              
              children: [
                Row(
                  children: [
                    Icon(
                      e.icon,
                      color: globals.primary,
                    ),
                    
                    const SizedBox(width: 10),
                    
                    Text(
                      e.name,
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 10),
                
                (e.callback != null) ? IconButton(
                  onPressed: () {
                    setState(() {
                      RadioButtonList.setGroup('Edit-${e.name}');
                    });
                
                    e.callback!(RadioButtonList.getGroup());
                  },
                  icon: const Icon(Icons.edit),
                  color: globals.primary,
                ) : const SizedBox(),
              ],
            ),
      
            subtitle: (e.description != null) ?
              Text(
                e.description!,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ) : null
          );
      
          
        }).toList(),
      
      )
    );
  }
}