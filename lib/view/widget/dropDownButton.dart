// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/model/standardListDropDown.dart';

class DropDown extends StatefulWidget {
  final String text;
  final List<DropDownList> itemsDropDownButton;
  final Function(String) callback;
  String? variavel;
  DropDown({
    super.key,
    required this.text,
    required this.itemsDropDownButton,
    required this.variavel,
    required this.callback,
  });

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {

  Widget dropDownGeneral() {
    print(widget.variavel);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: DropdownButtonFormField(
        dropdownColor: Colors.white,
        iconEnabledColor: globals.primary,
        borderRadius: BorderRadius.circular(10),
        decoration: InputDecoration(
          label: Text(
            widget.text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
      
          hintText: 'Selecione o(a) ${widget.text.toLowerCase()}',
          filled: true,
          fillColor: Colors.transparent,
          errorStyle: TextStyle(color: globals.primaryBlack),
        ),
        isExpanded: true,
        value: widget.variavel,
        items: widget.itemsDropDownButton.map((map) {
          print(map.name);
          return DropdownMenuItem<String> (
            value: map.name,
            child: DropdownButtonHideUnderline(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                
                children: [
                  Text(
                    map.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),

                  Icon(
                    map.icon,
                    color: globals.primaryBlack,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
        onChanged: (dynamic value) {
          setState(() {
            widget.variavel = value;
          });

          widget.itemsDropDownButton.forEach((element) {
            if (element.name == value) {
              element.onSelected!();
            }
          });
    
          widget.callback(widget.variavel!);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return dropDownGeneral();
  }
}