// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;

Widget textFieldNumberGeneral(label, variavel, context) {

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: globals.primary,
      boxShadow: const [
        BoxShadow(color: Colors.transparent, spreadRadius: 3),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 20),
      child: textField(label, variavel, context),
    ),
  );
}

Widget textField(label, variavel, context) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
    
    constraints: const BoxConstraints( 
      minWidth: 70,
    ),

    child: Center(
      child: TextFormField(
        controller: variavel,
        keyboardType: TextInputType.number,
        style: const TextStyle(
          fontSize: 24,
          color: Colors.white,
        ),

        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),

          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide:  const BorderSide(color: Colors.transparent ),
          ),
        ),

        validator: (value) {
          value = value!.replaceFirst(',', '.');
          if (int.tryParse(value) == null) {
            return 'Entre com um valor numérico';
          } else {
            if (value.isEmpty) {
              return 'Preencha o campo com as informações necessárias';
            }
            return null;
          }
        }
      )
    )
  );
}