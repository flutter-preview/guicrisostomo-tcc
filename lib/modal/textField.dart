import 'package:flutter/material.dart';

textField(rotulo, variavel) {
  return Container(
    margin: EdgeInsets.only(bottom: 15),
    child: TextFormField(
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
        
      },
    )
  );
}