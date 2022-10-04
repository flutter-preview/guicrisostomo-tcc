import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tcc/modal/button.dart';
import 'package:tcc/modal/textField.dart';

import '../modal/imageMainScreens.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  var txtEmail = TextEditingController();
  var txtPassword = TextEditingController();

  final String imgLogin = 'lib/images/imgLogin.svg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center ,
          children: [
            imgCenter(imgLogin),

            SizedBox(height: 50,),
            textField('E-mail', txtEmail),
            textField('Senha', txtPassword),
            button('Entrar', context, 'home'),
            SizedBox(height: 50,),

            Text(
              'Ainda não se registrou ?',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            button('Registrar agora', context, 'register')
        ],),
      ),
    );
  }
  
  dialogField(msg) {
    return showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pizzaria'),
          content: Text(
            msg,
            style: TextStyle(
              fontSize: 28,
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                //fechar caixa de dialogo
                Navigator.of(context).pop();
              },

              child: Text('Fechar'),
            )
          ],
        );
      }
    );
  }
}