import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

textFieldPassword(rotulo, variavel, context, fieldPassword) {
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
      child: Row(
        children: [
          textField(rotulo, variavel, context, fieldPassword),
          SvgPicture.asset(
            assetIconSeePassword,
            height: 50,
            width: 50,
          )
        ],
      ),
    ),
  );
}

textField(rotulo, variavel, context, fieldPassword) {
  return Container(
    margin: EdgeInsets.only(bottom: 15),
    width: MediaQuery.of(context).size.width - 120,

    constraints: BoxConstraints( 
      minWidth: 70,
    ),

    child: Center(
      child: TextFormField(
        controller: variavel,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,

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

          enabledBorder: new OutlineInputBorder(
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

          if (value == fieldPassword) {
            return 'As senhas devem ser iguais!';
          }
        },
      )
    )
  );
}