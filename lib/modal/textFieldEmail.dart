import 'package:flutter/material.dart';

textFieldEmail(rotulo, variavel) {
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
        if (value == null || value.isEmpty) {
          return 'Preencha o campo com as informações necessárias';
        }

        String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
        RegExp regex = RegExp(pattern);
        if (!regex.hasMatch(value))
          return 'Informe um e-mail válido';
        else
          return null;
      },
    )
  );
}