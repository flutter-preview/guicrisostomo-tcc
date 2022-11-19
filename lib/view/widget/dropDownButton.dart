// ignore_for_file: file_names

import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  final String text;
  final List<String> itemsDropDownButton;
  final Function(String?) callback;
  const DropDown({super.key, required this.text, required this.itemsDropDownButton, required this.callback});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String? itemSelecionado;

  Widget dropDownGeneral() {
    return DropdownButton(
      dropdownColor: const Color.fromRGBO(50, 62, 64, 1),
      iconEnabledColor: const Color.fromRGBO(242, 169, 34, 1),
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
      value: itemSelecionado,
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
          itemSelecionado = value;
        });

        widget.callback(itemSelecionado);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(50, 62, 64, 1),
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