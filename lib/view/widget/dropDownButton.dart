// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;

class DropDown extends StatefulWidget {
  final String text;
  final List<String> itemsDropDownButton;
  final Function(String) callback;
  String? itemSelecionado;
  DropDown({
    super.key,
    required this.text,
    required this.itemsDropDownButton,
    required this.callback,
    this.itemSelecionado
  });

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {

  Widget dropDownGeneral() {
    return DropdownButton(
      dropdownColor: globals.primary,
      iconEnabledColor: globals.secundary,
      borderRadius: BorderRadius.circular(10),
      underline: Container(),
      style: const TextStyle(color: Colors.white),
      hint: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          widget.text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      isExpanded: true,
      value: widget.itemSelecionado,
      items: widget.itemsDropDownButton.map((String item) {
        return DropdownMenuItem<String> (
          value: item,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              item,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        );
      }).toList(),
      onChanged: (dynamic value) {
        setState(() {
          widget.itemSelecionado = value;
        });

        widget.callback(widget.itemSelecionado!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: globals.primary,
        boxShadow: const [
          BoxShadow(color: Colors.transparent, spreadRadius: 3),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: dropDownGeneral(),
      ),
    );
  }
}