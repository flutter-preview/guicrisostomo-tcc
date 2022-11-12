// ignore_for_file: file_names

import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  final String text;
  final List<String> itemsDropDownButton;
  const DropDown({super.key, required this.text, required this.itemsDropDownButton});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String? itemSelecionado;

  @override
  Widget build(BuildContext context) {
    return(
      DropdownButton(
        focusColor: Colors.white,
        borderRadius: BorderRadius.circular(10),
        underline: Container(),
        style: const TextStyle(color: Colors.black),
        hint: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            widget.text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
        isExpanded: true,
        value: itemSelecionado,
        items: widget.itemsDropDownButton.map((String item) {
          return DropdownMenuItem<String> (
            value: item,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                item,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          );
        }).toList(),
        onChanged: (dynamic value) {
          setState(() {
            itemSelecionado = value;
          });
        },
      )
    );
  }
}