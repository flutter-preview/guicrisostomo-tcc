import 'package:flutter/material.dart';
import 'package:tcc/controller/firebase/auth.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/textFieldEmail.dart';
import 'package:tcc/globals.dart' as globals;

class ScreenForgetPassword extends StatefulWidget {
  const ScreenForgetPassword({super.key});

  @override
  State<ScreenForgetPassword> createState() => _ScreenForgetPasswordState();
}

class _ScreenForgetPasswordState extends State<ScreenForgetPassword> {
  var txtEmail = TextEditingController();
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
      appBar: AppBar(
        title: const Text('Recuperação de senha'),
        centerTitle: true,
        backgroundColor: globals.primary,
      ),

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
                'Digite seu e-mail usado no cadastro',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 5,),
              textFieldEmail('E-mail', txtEmail, context),
              
              const SizedBox(height: 10,),
        
              Container(
                alignment: Alignment.centerRight,
                child: button('Confirmar', 100, 50, () {

                  if (formKey.currentState!.validate()) {

                    LoginController().forgetPassword(txtEmail.text, context);

                  } else {
                    setState(() {
                      autoValidation = true;
                    });
                  }

                }),
              )
              
            ],
          ),
        ),
      ),
    );
  }
}