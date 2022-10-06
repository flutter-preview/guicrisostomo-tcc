import 'package:flutter/material.dart';

textFieldEmail(rotulo, variavel, context) {
  final String assetIconSeePassword = 'lib/images/iconSeePassword.svg';

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Color.fromRGBO(50, 62, 64, 1),
      boxShadow: [
        BoxShadow(color: Colors.transparent, spreadRadius: 3),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.only(left: 20),
      
      child: textField(rotulo, variavel, context),
    ),
  );
}

textField(rotulo, variavel, context) {
  return Container(
    margin: EdgeInsets.only(bottom: 15),
    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
    
    constraints: BoxConstraints( 
      minWidth: 70,
    ),

    child: Center(
      child: TextFormField(
        controller: variavel,
        keyboardType: TextInputType.emailAddress,

        style: TextStyle(
          fontSize: 24,
          color: Colors.white,
        ),

        decoration: InputDecoration(
          labelText: rotulo,
          labelStyle: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),

          enabledBorder: new UnderlineInputBorder(
            borderRadius: new BorderRadius.circular(20.0),
            borderSide:  BorderSide(color: Colors.transparent ),
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
    )
  );
}