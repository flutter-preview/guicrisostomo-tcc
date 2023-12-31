import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tcc/controller/auth/auth.dart';
import 'package:tcc/validators.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/imageMainScreens.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';

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

  var maskFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####', 
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy,
  );

  @override
  Widget build(BuildContext context) {

    void register() {
      if (formKey.currentState!.validate()) {
        
        LoginController.instance.createAccount(context, txtName.text, txtEmail.text, txtPhone.text, txtPassword.text);

      } else {
        setState(() {
          autoValidation = true;
        });
      }
    }
    
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

              
              TextFieldGeneral(
                label: 'Nome',
                variavel: txtName,
                context: context,
                keyboardType: TextInputType.name,
                ico: Icons.person,
                validator: (value) {
                  return validatorString(value!);
                },
                textCapitalization: TextCapitalization.sentences,
              ),

              const SizedBox(height: 20,),

              TextFieldGeneral(
                label: 'E-mail', 
                variavel: txtEmail,
                context: context, 
                keyboardType: TextInputType.emailAddress,
                ico: Icons.person,
                validator: (value) {
                  return validatorEmail(value!);
                },
                textCapitalization: TextCapitalization.sentences,
              ),

              const SizedBox(height: 20,),

              TextFieldGeneral(
                label: 'Telefone',
                variavel: txtPhone,
                context: context,
                keyboardType: TextInputType.phone,
                ico: Icons.phone,
                validator: (value) {
                  return validatorPhone(value!);
                },
                inputFormatter: [maskFormatter],
                
                onChanged: (value) => {
                  setState(() {
                    if (value.length <= 14) {
                      txtPhone.value =maskFormatter.updateMask(mask: "(##) ####-#####");
                    } else {
                      txtPhone.value =maskFormatter.updateMask(mask: "(##) #####-####");
                    }
                  }),
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
                  return validatorPassword(value!);
                },

                isPassword: true,
              ),

              const SizedBox(height: 20,),

              TextFieldGeneral(
                label: 'Confirmar senha', 
                variavel: txtConfirmPassword,
                context: context, 
                keyboardType: TextInputType.text,
                ico: Icons.lock,

                validator: (value) {
                  return validatorConfirmPassword(value!, txtPassword);
                },

                onFieldSubmitted: (value) => {
                  register()
                },

                isPassword: true,
              ),

              const SizedBox(height: 50,),

              button('Cadastrar', MediaQuery.of(context).size.width - 100, 0, Icons.person_add_outlined, () {

                register();

              }),

              const SizedBox(height: 20,),

              button('Entrar com Google', MediaQuery.of(context).size.width - 100, 0, null, () {
                LoginController.instance.signIn(context);
              }, true, 24, null, 'lib/images/google_logo.png'),

              const SizedBox(height: 50,),

              const Text(
                'Já possui cadastro ?',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 5,),

              button('Entrar agora', 280, 50, Icons.input_outlined, () {
                
                GoRouter.of(context).go('/login');
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
              },

              child: const Text('Fechar'),
            )
          ],
        );
      }
    );
  }
}