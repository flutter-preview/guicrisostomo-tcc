import 'package:flutter/material.dart';
import 'package:tcc/controller/firebase/auth.dart';
import 'package:tcc/view/widget/bottonNavigationCustomer.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/floatingButton.dart';
import 'package:tcc/view/widget/textField.dart';
import 'package:tcc/view/widget/textFieldEmail.dart';
import 'package:tcc/view/widget/textFieldPhone.dart';
import 'package:tcc/globals.dart' as globals;

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments as dynamic;

    txtName.text = user.data()['name'];
    txtEmail.text = user.data()['email'];

    if (user.data()['phone'] != null) {
      txtPhone.text = user.data()['phone'];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar dados'),
        centerTitle: true,
        backgroundColor: globals.primary,
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
              textFieldPhone('Telefone', txtPhone, context, txtPhone.text),
              const SizedBox(height: 50,),

              button('Salvar', 100, 50, Icons.save, () {

                if (formKey.currentState!.validate()) {
          
                  LoginController().updateUser(user.id, txtName.text, txtEmail.text, txtPhone.text, context);

                } else {
                  setState(() {
                    autoValidation = true;
                  });
                }

              })
            ]
          ),
        ),
      ),

      bottomNavigationBar: const Bottom(),
      floatingActionButton: floatingButton(context),
    );
  }
}