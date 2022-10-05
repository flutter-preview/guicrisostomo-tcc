import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tcc/modal/textFieldEmail.dart';
import 'package:tcc/modal/textFieldPassword.dart';

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
  
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var txtEmail = TextEditingController();
    var txtPassword = TextEditingController();
    var txtConfirmPassword = TextEditingController();
    var txtName = TextEditingController();
    var txtPhone = TextEditingController();
    
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),

        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center ,
            children: [
              imgCenter(imgRegister),

              SizedBox(height: 50,),

              textFieldGeneral('Nome', txtName, context),
              SizedBox(height: 10,),
              textFieldEmail('E-mail', txtEmail, context),
              SizedBox(height: 10,),
              textFieldGeneral('Telefone', txtPhone, context),
              SizedBox(height: 10,),
              textFieldPassword('Senha', txtPassword, context),
              SizedBox(height: 10,),
              textFieldPassword('Confirmar senha', txtConfirmPassword, context),

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
        )
      ),
    );
  }
}