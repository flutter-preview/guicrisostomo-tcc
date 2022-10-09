// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextFieldConfirmPassword extends StatefulWidget {
  final String rotulo;
  final TextEditingController variavel;
  final String fieldPassword;

  const TextFieldConfirmPassword({super.key, required this.rotulo, required this.variavel, required this.fieldPassword});

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
        color: const Color.fromRGBO(50, 62, 64, 1),
        boxShadow: const [
          BoxShadow(color: Colors.transparent, spreadRadius: 3),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          children: [
            textField(widget.rotulo, widget.variavel, widget.fieldPassword),
            
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

  Widget textField (rotulo, variavel, fieldPassword) {
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
            color: Colors.white,
          ),

          decoration: InputDecoration(
            labelText: rotulo,
            labelStyle: const TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),

            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide:  const BorderSide(color: Colors.transparent ),
            ),
          ),
          
          //
          // VALIDAÇÃO
          //

          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Preencha o campo com as informações necessárias';
            }

            if (value != fieldPassword) {
              return 'As senhas devem ser iguais';
            }
            return null;
          },
        )
      )
    );
  }
}