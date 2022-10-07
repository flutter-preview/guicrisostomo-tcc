import 'package:flutter/material.dart';
import 'package:tcc/modal/button.dart';

import '../modal/bottonNavigationCustomer.dart';
import '../modal/textField.dart';
import '../modal/textFieldEmail.dart';
import '../modal/textFieldPhone.dart';

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
        title: Text('Editar dados'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(50, 62, 64, 1),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),

        child: Container(
          child: Form(
            key: formKey,
            autovalidateMode: autoValidation ? AutovalidateMode.always : AutovalidateMode.disabled,

            child: Column(
              children: [
                textFieldGeneral('Nome', txtName, context),
                SizedBox(height: 10,),
                textFieldEmail('E-mail', txtEmail, context),
                SizedBox(height: 10,),
                TextFieldPhone('Telefone', txtPhone, context, txtPhone.text),
                SizedBox(height: 50,),

                buttonSave(),
              ]
            ),
          ),
        ),
      ),

      bottomNavigationBar: Bottom(),
    );
  }

  buttonSave() {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(100, 50),
          primary: Color.fromRGBO(50, 62, 64, 1),
          
        ),
        
        child: Text('Salvar',
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
      ),
    );
  }
}