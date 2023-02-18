import 'package:flutter/material.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/textFieldConfirmPassword.dart';
import 'package:tcc/view/widget/textFieldPassword.dart';

class ScreenResetPassword extends StatefulWidget {
  const ScreenResetPassword({super.key});

  @override
  State<ScreenResetPassword> createState() => _ScreenResetPasswordState();
}

class _ScreenResetPasswordState extends State<ScreenResetPassword> {
  var txtPassword = TextEditingController();
  var txtConfirmPassword = TextEditingController();
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          autovalidateMode: autoValidation ? AutovalidateMode.always : AutovalidateMode.disabled,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Digite sua nova senha',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10,),
              TextFieldPassword(label: 'Senha', variavel: txtPassword, onFieldSubmitted: (a) {}),
              const SizedBox(height: 5,),
              TextFieldConfirmPassword(label: 'Confirmar senha', variavel: txtConfirmPassword, fieldPassword: txtPassword),

              const SizedBox(height: 10,),

              Container(
                alignment: Alignment.centerRight,
                child: button('Confirmar', 100, 50, Icons.check, () {

                  if (formKey.currentState!.validate()) {

                    Navigator.of(context).pop();
                    Navigator.pushNamed(
                      context,
                      'home',
                    );

                  } else {
                    setState(() {
                      autoValidation = true;
                    });
                  }

                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}