// ignore_for_file: file_names

import 'package:flutter/material.dart';

textFieldGeneral(rotulo, variavel, context) {
  // ignore: prefer_const_declarations

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: const Color.fromRGBO(50, 62, 64, 1),
      boxShadow: const [
        BoxShadow(color: Colors.transparent, spreadRadius: 3),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 20),
      
      child: textField(rotulo, variavel, context),
    ),
  );
}

textField(rotulo, variavel, context) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
    
    constraints: const BoxConstraints( 
      minWidth: 70,
    ),

    child: Center(
      child: TextFormField(
        controller: variavel,

        style: const TextStyle(
          fontSize: 24,
          color: Colors.white,
        ),

        decoration: InputDecoration(
          labelText: rotulo,
          labelStyle: const TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),

          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide:  const BorderSide(color: Colors.transparent ),
          ),
        ),
        
        //
        // VALIDAÇÃO
        //

        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Preencha o campo com as informações necessárias';
          }
          return null;
        }
      )
    )
  );
}