import 'package:flutter/material.dart';
import 'package:tcc/model/button.dart';
import '../model/imageMainScreens.dart';
import '../model/textFieldEmail.dart';
import '../model/textFieldPassword.dart';

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
              textFieldEmail('E-mail', txtEmail, context),
              
              const SizedBox(height: 10,),

              TextFieldPassword(rotulo: 'Senha', variavel: txtPassword),
              
              const SizedBox(height: 50,),

              buttonLogin(),
              const SizedBox(height: 50,),

              const Text(
                'Ainda não se registrou ?',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              button('Registrar agora', context, 'register')
          ],),
        )
      ),
    );
  }

  buttonLogin() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(100, 50), backgroundColor: const Color.fromRGBO(50, 62, 64, 1),
        
      ),
      
      child: const Text('Entrar',
        style: TextStyle(
        fontSize: 24,
      )
      ),

      //COMPORTAMENTO
      onPressed: () {

        //DISPARAR O PROCESSO DE VALIDAÇÃO
        if (formKey.currentState!.validate()) {
          //Se o formulário foi VALIDADO
        
          Navigator.of(context).pop();
          Navigator.pushNamed(
            context,
            'home',
          );

        } else {
          setState(() {
            autoValidation = true;
          });
          
          dialogField("Informe os campos corretamente");
        }
        
      },
    );
  }

  dialogField(msg) {
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