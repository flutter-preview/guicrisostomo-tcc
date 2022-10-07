import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

TextFieldPhone(rotulo, variavel, context, initialText) {
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
      
      child: textField(rotulo, variavel, context, initialText),
    ),
  );
}

textField(rotulo, variavel, context, initialText) {
  var maskFormatter = new MaskTextInputFormatter(
    mask: '(##) #####-####', 
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.eager,
    initialText: initialText,
  );

  return Container(
    margin: EdgeInsets.only(bottom: 15),
    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
    
    constraints: BoxConstraints( 
      minWidth: 70,
    ),

    child: Center(
      child: TextFormField(
        controller: variavel,
        keyboardType: TextInputType.number,
        inputFormatters: [maskFormatter],

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
          value = value!.replaceAll(RegExp('[^0-9A-Za-z]'), '');

          if (int.tryParse(value) == null) {
            //o usuário NÃo digitou um valr numérico
            return 'Entre com um valor numérico';
          } else {
            //Tudo CERTO, o valor digitado é numérico
            return null;
          }

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