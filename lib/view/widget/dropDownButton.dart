// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/model/standardListDropDown.dart';

class DropDown extends StatefulWidget {
  final String? text;
  final List<DropDownList> itemsDropDownButton;
  final void Function(String?)? callback;
  String? variavel;
  final List<double>? size;

  DropDown({
    super.key,
    this.text,
    required this.itemsDropDownButton,
    required this.variavel,
    required this.callback,
    this.size,
  });

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {

  Widget dropDownGeneral() {
    return SizedBox(
      height: widget.size?[1],
      width: widget.size != null ? widget.size![0] : MediaQuery.of(context).size.width * 0.8,
      child: DropdownButtonFormField(
        dropdownColor: Colors.white,
        iconEnabledColor: globals.primary,
        borderRadius: BorderRadius.circular(10),
        decoration: widget.text != null ? InputDecoration(
          label: Text(
            widget.text!,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
      
          hintText: 'Selecione o(a) ${widget.text!.toLowerCase()}',
          filled: true,
          fillColor: Colors.transparent,
          errorStyle: TextStyle(color: globals.primaryBlack),
        ) : null,
        isExpanded: true,
        value: widget.variavel,
        items: widget.itemsDropDownButton.map((map) {
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

                  (map.icon != null) ?
                    Icon(
                      map.icon,
                      color: globals.primaryBlack,
                    )
                  : map.widget!,
                ],
              ),
            ),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            widget.variavel = value;
            widget.callback!(value);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return dropDownGeneral();
  }
}