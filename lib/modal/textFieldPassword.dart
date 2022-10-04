import 'package:flutter/material.dart';

textField(rotulo, variavel) {
  return Container(
    margin: EdgeInsets.only(bottom: 15),
    child: TextFormField(
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      
      controller: variavel,
      style: TextStyle(
        fontSize: 28,
      ),
      decoration: InputDecoration(
        labelText: rotulo,
        labelStyle: TextStyle(
          fontSize: 24,
          color: Colors.grey,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      //
      // VALIDAÇÃO
      //

      validator: (value) {
        if (value!.isEmpty) {
          return 'Preencha o campo com as informações necessárias';
        }
      },
    )
  );
}