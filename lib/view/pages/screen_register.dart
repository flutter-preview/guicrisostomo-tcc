import 'package:flutter/material.dart';
import 'package:tcc/controller/firebase/auth.dart';
import 'package:tcc/controller/firebase/authGoogle.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/buttonGoogleAuth.dart';
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
              const SizedBox(height: 20,),
              textFieldEmail('E-mail', txtEmail, context),
              const SizedBox(height: 20,),
              textFieldPhone('Telefone', txtPhone, context, ''),
              const SizedBox(height: 20,),
              TextFieldPassword(label: 'Senha', variavel: txtPassword, onFieldSubmitted: (a) {},),
              const SizedBox(height: 20,),
              TextFieldConfirmPassword(label: 'Confirmar senha', variavel: txtConfirmPassword, fieldPassword: txtPassword),
              
              const SizedBox(height: 50,),

              button('Cadastrar', 295, 50, Icons.person_add_outlined, () {

                if (formKey.currentState!.validate()) {
        
                  LoginController().createAccount(context, txtName.text, txtEmail.text, txtPhone.text, txtPassword.text);

                } else {
                  setState(() {
                    autoValidation = true;
                  });
                }

              }),

              const SizedBox(height: 20,),

              GoogleSignInButton(),
              const SizedBox(height: 50,),

              const Text(
                'Já possui cadastro ?',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 5,),

              button('Entrar agora', 100, 50, Icons.input_outlined, () {
                Navigator.popAndPushNamed(context, 'login');
              })
          ],),
        )
      ),
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