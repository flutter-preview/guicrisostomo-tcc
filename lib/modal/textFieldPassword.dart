import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

textFieldPassword(rotulo, variavel, context) {
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
          textField(rotulo, variavel, context),
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

textField(rotulo, variavel, context) {
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
        },
      )
    )
  );
}