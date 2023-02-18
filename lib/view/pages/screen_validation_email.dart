import 'package:flutter/material.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/textFieldNumberGeneral.dart';
import 'package:tcc/globals.dart' as globals;

class ScreenValidationEmail extends StatefulWidget {
  const ScreenValidationEmail({super.key});

  @override
  State<ScreenValidationEmail> createState() => _ScreenValidationEmailState();
}

class _ScreenValidationEmailState extends State<ScreenValidationEmail> {
  var txtCodigo = TextEditingController();
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
                'Digite o código enviado ao e-mail',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10,),
              textFieldNumberGeneral('Código', txtCodigo, context),
        
              const SizedBox(height: 10,),

              Container(
                alignment: Alignment.centerRight,
                child: button('Confirmar', 100, 50, Icons.check, () {

                  if (formKey.currentState!.validate()) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();

                    Navigator.pushNamed(
                      context,
                      'login/forget_password/reset_password',
                    );

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