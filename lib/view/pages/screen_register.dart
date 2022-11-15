import 'package:flutter/material.dart';
import 'package:tcc/controller/firebase/auth.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/imageMainScreens.dart';
import 'package:tcc/view/widget/textField.dart';
import 'package:tcc/view/widget/textFieldConfirmPassword.dart';
import 'package:tcc/view/widget/textFieldEmail.dart';
import 'package:tcc/view/widget/textFieldPassword.dart';
import 'package:tcc/view/widget/textFieldPhone.dart';

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
              textFieldPhone('Telefone', txtPhone, context, ''),
              const SizedBox(height: 10,),
              TextFieldPassword(label: 'Senha', variavel: txtPassword),
              const SizedBox(height: 10,),
              TextFieldConfirmPassword(label: 'Confirmar senha', variavel: txtConfirmPassword, fieldPassword: txtPassword),
              
              const SizedBox(height: 50,),

              buttonRegister(context),
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

  Widget buttonRegister(context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(100, 50), backgroundColor: const Color.fromRGBO(50, 62, 64, 1),
        
      ),
      
      child: const Text('Entrar',
        style: TextStyle(
          fontSize: 24,
        )
      ),
      onPressed: () {

        if (formKey.currentState!.validate()) {
        
          LoginController().createAccount(context, txtName.text, txtEmail.text, txtPhone.text, txtPassword.text);

        } else {
          setState(() {
            autoValidation = true;
          });
        }
      },
    );
  }

  Future dialogField(msg) {
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