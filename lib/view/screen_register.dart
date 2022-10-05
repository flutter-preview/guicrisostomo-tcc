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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center ,
          children: [
            imgCenter(imgRegister),

            SizedBox(height: 50,),

            textFieldGeneral('Nome', txtName, context),
            SizedBox(height: 10,),
            textFieldGeneral('E-mail', txtEmail, context),
            SizedBox(height: 10,),
            textFieldGeneral('Telefone', txtPhone, context),
            SizedBox(height: 10,),
            textFieldGeneral('Senha', txtSenha, context),
            
            SizedBox(height: 50,),

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