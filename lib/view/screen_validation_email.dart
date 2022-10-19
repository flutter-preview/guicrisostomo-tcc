import 'package:flutter/material.dart';
import 'package:tcc/widget/textField.dart';

import '../widget/button.dart';
import '../widget/textFieldNumberGeneral.dart';

class ScreenValidationEmail extends StatefulWidget {
  const ScreenValidationEmail({super.key});

  @override
  State<ScreenValidationEmail> createState() => _ScreenValidationEmailState();
}

class _ScreenValidationEmailState extends State<ScreenValidationEmail> {
  var txtCodigo = TextEditingController();

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
            button('Confirmar', context, 'login/forget_password/reset_password')
          ],
        ),
      ),
    );
  }
}