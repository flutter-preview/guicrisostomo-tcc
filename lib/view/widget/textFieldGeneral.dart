// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;

class TextFieldGeneral extends StatefulWidget {
  String label;
  TextEditingController variavel;
  BuildContext context;
  TextInputType keyboardType;
  IconData ico;
  String? Function(String?)? validator;
  void Function(String)? onFieldSubmitted = (value) {};
  void Function(String)? onChanged = (value) {};
  bool isPassword = false;
  bool isPasswordVisible = false;

  TextFieldGeneral
    ({
      super.key,
      required this.label,
      required this.variavel,
      required this.context,
      required this.keyboardType,
      required this.ico,
      required this.validator,
      this.onFieldSubmitted,
      this.onChanged,
      this.isPassword = false,
      this.isPasswordVisible = false
    });

  @override
  State<TextFieldGeneral> createState() => _TextFieldGeneralState();
}

class _TextFieldGeneralState extends State<TextFieldGeneral> {

  Widget textField() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0,0, 10, 15),
      
      constraints: const BoxConstraints( 
        minWidth: 70,
      ),

      child: Center(
        child: TextFormField(
          controller: widget.variavel,
          keyboardType: widget.isPasswordVisible ? TextInputType.visiblePassword : widget.keyboardType,
          obscureText: widget.isPassword ? !widget.isPasswordVisible : false,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),

          decoration: InputDecoration(
            isDense: true,
            labelText: widget.label,
            labelStyle: const TextStyle(
              fontSize: 24,
              color: Colors.black,
            ),

            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide:  const BorderSide(color: Colors.black ),
            ),

            iconColor: MaterialStateColor.resolveWith((states) =>
              states.contains(MaterialState.focused)
                  ? globals.primaryBlack
                  : globals.primary),

            icon: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Icon(
                widget.ico,
                size: 30
              ),
            ),

            suffixIcon: widget.isPassword ? IconButton(
              icon: Icon(
                widget.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: MaterialStateColor.resolveWith((states) =>
                  states.contains(MaterialState.focused)
                      ? globals.primaryBlack
                      : globals.primary),
              ),
              onPressed: () {
                setState(() {
                  widget.isPasswordVisible = !widget.isPasswordVisible;
                });
              },
            ) : null,
          ),

          validator: widget.validator,

          onFieldSubmitted: widget.onFieldSubmitted,

          onChanged: widget.onChanged,

          // value = value!.replaceFirst(',', '.');
          //   if (int.tryParse(value) == null) {
          //     return 'Entre com um valor numérico';
          //   } else {
          //     if (value.isEmpty) {
          //       return 'Preencha o campo com as informações necessárias';
          //     }
          //     return null;
          //   }

          //email
          // if (value == null || value.isEmpty) {
          //     return 'Preencha o campo com as informações necessárias';
          //   }

          //   String pattern =
          //   r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          //   r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          //   r"{0,253}[a-zA-Z0-9])?)*$";
          //   RegExp regex = RegExp(pattern);
          //   if (!regex.hasMatch(value)) {
          //     return 'Informe um e-mail válido';
          //   } else {
          //     return null;
          //   }

          //senha
          // if (variavel.text == null || variavel.text.isEmpty) {
          //       return 'Preencha o campo com as informações necessárias';
          //     }
          //csenha
          //     if (variavel.text != fieldPassword.text) {
          //       return 'As senhas devem ser iguais';
          //     }

          //     return null;

          //num
          // value = value!.replaceAll(RegExp('[^0-9A-Za-z]'), '');

          //   if (int.tryParse(value) == null) {
          //     return 'Entre com um valor numérico';
          //   }

          //   if (variavel.text.length < 14) {
          //     return 'Informe um número de telefone válido';
          //   }

          //   return null;

          
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final String assetIconSeePassword = 'lib/images/iconSeePassword.svg';
    final String assetIconHidePassword = 'lib/images/iconHidePassword.svg';

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: MaterialStateColor.resolveWith((states) =>
              states.contains(MaterialState.focused)
                  ? globals.primaryBlack
                  : globals.primary),
            spreadRadius: 1,
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: textField(),
      ),
    );
  }
}