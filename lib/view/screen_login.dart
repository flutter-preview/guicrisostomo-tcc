import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tcc/modal/button.dart';
import 'package:tcc/modal/textField.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  var txtEmail = TextEditingController();
  var txtPassword = TextEditingController();

  final String assetRegister = 'lib/images/imgLogin.svg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center ,
          children: [
            SvgPicture.asset(
              assetRegister,
              height: 220,
              fit: BoxFit.fill,
            ),

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
}