import 'package:flutter/material.dart';
import 'package:tcc/controller/firebase/auth.dart';
import 'package:tcc/utils.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/buttonGoogleAuth.dart';
import 'package:tcc/view/widget/imageMainScreens.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';

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
                keyboardType: TextInputType.none,
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
                    button('Esqueci minha senha', 300, 50, null, () {
                      Navigator.pushNamed(
                        context,
                        'login/forget_password',
                      );
                    }),
                  ],
                )
              ),
              

              const SizedBox(height: 40,),

              button('Entrar', 295, 50, Icons.input_outlined, () {

                logIn();

              }, false),

              const SizedBox(height: 20,),

              GoogleSignInButton(),
              
              const SizedBox(height: 50,),

              const Text(
                'Ainda não se registrou ?',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 5,),

              button('Registrar agora', 280, 50, Icons.person_add, () {
                Navigator.popAndPushNamed(context, 'register');
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