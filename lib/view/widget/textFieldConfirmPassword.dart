// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tcc/globals.dart' as globals;

class TextFieldConfirmPassword extends StatefulWidget {
  final String label;
  final TextEditingController variavel;
  final TextEditingController fieldPassword;

  const TextFieldConfirmPassword({super.key, required this.label, required this.variavel, required this.fieldPassword});

  @override
  State<TextFieldConfirmPassword> createState() => _TextFieldConfirmPasswordState();
}

class _TextFieldConfirmPasswordState extends State<TextFieldConfirmPassword> {
  bool _passwordVisible = true;
  final String assetIconSeePassword = 'lib/images/iconSeePassword.svg';
  final String assetIconHidePassword = 'lib/images/iconHidePassword.svg';
  
  @override
  void initState() {
    _passwordVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: globals.primary, spreadRadius: 1),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          children: [
            textField(widget.label, widget.variavel, widget.fieldPassword),
            
            GestureDetector(
              child: SvgPicture.asset(
                _passwordVisible ? assetIconSeePassword : assetIconHidePassword,
                height: 50,
                width: 50,
              ),

              onTap: () => {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                })
              },
            )
          ],
        ),
      ),
    );
  }

  Widget textField (label, variavel, fieldPassword) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: MediaQuery.of(context).size.width - 120,

      constraints: const BoxConstraints( 
        minWidth: 70,
      ),

      child: Center(
        child: TextFormField(
          
          controller: variavel,
          obscureText: _passwordVisible,
          enableSuggestions: false,
          autocorrect: false,

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
              borderSide:  const BorderSide(color: Colors.black ),
            ),
          ),

          validator: (value) {
            if (variavel.text == null || variavel.text.isEmpty) {
              return 'Preencha o campo com as informações necessárias';
            }

            if (variavel.text != fieldPassword.text) {
              return 'As senhas devem ser iguais';
            }

            return null;
          },
        )
      )
    );
  }
}