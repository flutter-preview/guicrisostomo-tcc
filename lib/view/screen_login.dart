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

  var formKey = GlobalKey<FormState>();
  
  final String imgLogin = 'lib/images/imgLogin.svg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: formKey,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center ,
            children: [
              imgCenter(imgLogin),

              SizedBox(height: 50,),
              textField('E-mail', txtEmail),
              textField('Senha', txtPassword),
              buttonLogin(),
              SizedBox(height: 50,),

              Text(
                'Ainda não se registrou ?',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              button('Registrar agora', context, 'register')
          ],),
        )
      ),
    );
  }

  buttonLogin() {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(100, 50),
          primary: Color.fromRGBO(50, 62, 64, 1),
          
        ),
        
        child: Text('Entrar',
          style: TextStyle(
          fontSize: 24,
        )
        ),

        //COMPORTAMENTO
        onPressed: () {

          //DISPARAR O PROCESSO DE VALIDAÇÃO
          if (formKey.currentState!.validate()) {
            //Se o formulário foi VALIDADO
          
            Navigator.of(context).pop();
            Navigator.pushNamed(
              context,
              'home',
            );

          } else {
            dialogField("Informe os campos corretamente");
          }
          
        },
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