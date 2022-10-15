import 'package:flutter/material.dart';
import 'package:tcc/widget/textFieldEmail.dart';
import 'package:tcc/widget/textFieldPassword.dart';
import 'package:tcc/widget/textFieldPhone.dart';

import '../widget/button.dart';
import '../widget/imageMainScreens.dart';
import '../widget/textField.dart';
import '../widget/textFieldConfirmPassword.dart';

class ScreenRegister extends StatefulWidget {
  const ScreenRegister({super.key});

  @override
  State<ScreenRegister> createState() => _ScreenRegisterState();
}

class _ScreenRegisterState extends State<ScreenRegister> {
  var txtEmail = TextEditingController();
  var txtPassword = TextEditingController();
  var txtConfirmPassword = TextEditingController();
  var txtName = TextEditingController();
  var txtPhone = TextEditingController();

  final String imgRegister = 'lib/images/imgRegister.svg';
  
  var formKey = GlobalKey<FormState>();

  bool autoValidation = false;

  @override
  void initState() {
    autoValidation = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: formKey,
          autovalidateMode: autoValidation ? AutovalidateMode.always : AutovalidateMode.disabled,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center ,
            children: [
              imgCenter(imgRegister),

              const SizedBox(height: 50,),

              textFieldGeneral('Nome', txtName, context),
              const SizedBox(height: 10,),
              textFieldEmail('E-mail', txtEmail, context),
              const SizedBox(height: 10,),
              TextFieldPhone('Telefone', txtPhone, context, ''),
              const SizedBox(height: 10,),
              TextFieldPassword(rotulo: 'Senha', variavel: txtPassword),
              const SizedBox(height: 10,),
              TextFieldConfirmPassword(rotulo: 'Confirmar senha', variavel: txtConfirmPassword, fieldPassword: txtPassword.text),
              
              const SizedBox(height: 50,),

              buttonRegister(),
              const SizedBox(height: 50,),

              const Text(
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

  buttonRegister() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(100, 50), backgroundColor: const Color.fromRGBO(50, 62, 64, 1),
        
      ),
      
      child: const Text('Entrar',
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
          setState(() {
            autoValidation = true;
          });

          dialogField("Informe os campos corretamente");
        }
        
      },
    );
  }

  dialogField(msg) {
    return showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pizzaria'),
          content: Text(
            msg,
            style: const TextStyle(
              fontSize: 28,
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                //fechar caixa de dialogo
                Navigator.of(context).pop();
              },

              child: const Text('Fechar'),
            )
          ],
        );
      }
    );
  }
}