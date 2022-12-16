// ignore_for_file: file_names

import 'package:flutter/material.dart';

Widget textFieldEmail(label, variavel, context) {

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
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
        keyboardType: TextInputType.emailAddress,

        style: const TextStyle(
          fontSize: 24,
          color: Colors.black,
        ),

        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),

          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide:  const BorderSide(color: Colors.transparent ),
          ),
        ),

        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Preencha o campo com as informações necessárias';
          }

          String pattern =
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          r"{0,253}[a-zA-Z0-9])?)*$";
          RegExp regex = RegExp(pattern);
          if (!regex.hasMatch(value)) {
            return 'Informe um e-mail válido';
          } else {
            return null;
          }
        },
      )
    )
  );
}