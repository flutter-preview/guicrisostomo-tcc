import 'package:flutter/material.dart';
import 'package:tcc/view/widget/textFieldNumberGeneral.dart';

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
        backgroundColor: const Color.fromRGBO(50, 62, 64, 1),
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
                child: buttonConfirmCode(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonConfirmCode() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(100, 50), backgroundColor: const Color.fromRGBO(50, 62, 64, 1),
      ),
      
      child: const Text('Confirmar',
        style: TextStyle(
          fontSize: 24,
        )
      ),

      onPressed: () {
        
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
      },
    );
  }
}