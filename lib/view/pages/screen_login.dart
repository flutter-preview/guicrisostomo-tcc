import 'package:flutter/material.dart';
import 'package:tcc/controller/firebase/auth.dart';
import 'package:tcc/main.dart';
import 'package:tcc/utils.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/imageMainScreens.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';
import 'package:tcc/globals.dart' as globals;

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  var txtEmail = TextEditingController();
  var txtPassword = TextEditingController();

  var formKey = GlobalKey<FormState>();
  
  bool autoValidation = false;

  final String imgLogin = 'lib/images/imgLogin.svg';

  @override
  void initState() {
    autoValidation = false;
    super.initState();
  }

  void logIn() {
    if (formKey.currentState!.validate()) {
      LoginController().login(context, txtEmail.text, txtPassword.text);
    } else {
      setState(() {
        autoValidation = true;
      });
    }
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
              imgCenter(imgLogin),

              const SizedBox(height: 50,),

              TextFieldGeneral(
                label: 'E-mail', 
                variavel: txtEmail,
                context: context, 
                keyboardType: TextInputType.emailAddress,
                ico: Icons.person,
                validator: (value) {
                  validatorEmail(value!);
                },
              ),
              
              const SizedBox(height: 20,),

              TextFieldGeneral(
                label: 'Senha', 
                variavel: txtPassword,
                context: context, 
                keyboardType: TextInputType.text,
                ico: Icons.lock,

                validator: (value) {
                  validatorPassword(value!);
                },

                onFieldSubmitted: (value) => {
                  logIn()
                },

                isPassword: true,
              ),
              
              const SizedBox(height: 20,),

              Container(
                alignment: Alignment.centerRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          navigator('login/forget_password'),
                        );
                      }, 
                      child: Text(
                        'Esqueceu a senha ?',
                        style: TextStyle(
                          fontSize: 16,
                          color: globals.primary,
                        ),
                      ),
                    ),
                  ],
                )
              ),
              

              const SizedBox(height: 40,),

              button('Entrar', MediaQuery.of(context).size.width - 100, 0, Icons.input_outlined, () {

                logIn();

              }, false),

              const SizedBox(height: 20,),

              button('Entrar com Google', MediaQuery.of(context).size.width - 100, 0, null, () {
                LoginController().signIn(context);
              }, true, 24, null, 'lib/images/google_logo.png'),
              
              const SizedBox(height: 50,),

              const Text(
                'Ainda não se registrou ?',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 5,),

              button('Registrar agora', 280, 50, Icons.person_add, () {
                Navigator.pop(context);
                Navigator.push(context, navigator('register'));
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