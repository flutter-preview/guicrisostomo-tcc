// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

Widget textFieldPhone(label, variavel, context, initialText) {

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
      
      child: textField(label, variavel, context, initialText),
    ),
  );
}

Widget textField(label, variavel, context, initialText) {
  var maskFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####', 
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.eager,
    initialText: initialText,
  );

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
        inputFormatters: [maskFormatter],

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
          value = value!.replaceAll(RegExp('[^0-9A-Za-z]'), '');

          if (int.tryParse(value) == null) {
            return 'Entre com um valor numérico';
          }

          if (variavel.text.length < 14) {
            return 'Informe um número de telefone válido';
          }

          return null;

        },

        onChanged: (value) {
          if (value.length <= 14) {
            variavel.value = maskFormatter.updateMask(mask: "(##) ####-#####");
          } else {
            variavel.value = maskFormatter.updateMask(mask: "(##) #####-####");
          }
        },
      )
    )
  );
}