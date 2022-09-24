import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../modal/button.dart';
import '../modal/imageMainScreens.dart';
import '../modal/textField.dart';

class ScreenRegister extends StatefulWidget {
  const ScreenRegister({super.key});

  @override
  State<ScreenRegister> createState() => _ScreenRegisterState();
}

class _ScreenRegisterState extends State<ScreenRegister> {
  final String imgRegister = 'lib/images/imgRegister.svg';
  
  @override
  Widget build(BuildContext context) {
    var txtEmail = TextEditingController();
    var txtSenha = TextEditingController();
    var txtName = TextEditingController();
    var txtPhone = TextEditingController();
    
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center ,
          children: [
            imgCenter(imgRegister),

            SizedBox(height: 50,),
            textField('E-mail', txtEmail),
            textField('Senha', txtSenha),
            button('Entrar', context, 'home'),
            SizedBox(height: 50,),

            Text(
              'Já possui cadastro ?',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            button('Entrar agora', context, 'login')
        ],),
      ),
    );
  }
}