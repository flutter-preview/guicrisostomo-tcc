import 'package:flutter/material.dart';
import 'package:tcc/controller/auth/auth.dart';
import 'package:tcc/utils.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/textFieldGeneral.dart';

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          pageName: 'Esqueci minha senha',
          withoutIcons: true,
          context: context,
        ),
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
              
              const SizedBox(height: 10,),
        
              Container(
                alignment: Alignment.centerRight,
                child: button('Confirmar', 100, 50, Icons.check, () {

                  if (formKey.currentState!.validate()) {

                    LoginController.instance.forgetPassword(txtEmail.text, context);

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