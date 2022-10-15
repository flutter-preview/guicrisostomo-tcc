import 'package:flutter/material.dart';

import '../widget/bottonNavigationCustomer.dart';
import '../widget/textField.dart';
import '../widget/textFieldEmail.dart';
import '../widget/textFieldPhone.dart';

class ScreenEditDatas extends StatefulWidget {
  const ScreenEditDatas({super.key});

  @override
  State<ScreenEditDatas> createState() => _ScreenEditDatasState();
}

class _ScreenEditDatasState extends State<ScreenEditDatas> {
  var txtEmail = TextEditingController();
  var txtName = TextEditingController();
  var txtPhone = TextEditingController();

  bool autoValidation = false;

  var formKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    autoValidation = false;
    txtName.text = 'Rodrigo';
    txtEmail.text = 'rodrigo@gmail.com';
    txtPhone.text = '(16) 99999-9999';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar dados'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(50, 62, 64, 1),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: formKey,
          autovalidateMode: autoValidation ? AutovalidateMode.always : AutovalidateMode.disabled,

          child: Column(
            children: [
              textFieldGeneral('Nome', txtName, context),
              const SizedBox(height: 10,),
              textFieldEmail('E-mail', txtEmail, context),
              const SizedBox(height: 10,),
              TextFieldPhone('Telefone', txtPhone, context, txtPhone.text),
              const SizedBox(height: 50,),

              buttonSave(),
            ]
          ),
        ),
      ),

      bottomNavigationBar: const Bottom(),
    );
  }

  buttonSave() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(100, 50), backgroundColor: const Color.fromRGBO(50, 62, 64, 1),
        
      ),
      
      child: const Text('Salvar',
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
        }
        
      },
    );
  }
}