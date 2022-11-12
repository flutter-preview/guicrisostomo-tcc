import 'package:flutter/material.dart';
import 'package:tcc/view/widget/textField.dart';
import 'package:tcc/view/widget/textFieldNumberGeneral.dart';

import '../widget/bottonNavigationCustomer.dart';

class ScreenCreateProducts extends StatefulWidget {
  const ScreenCreateProducts({super.key});

  @override
  State<ScreenCreateProducts> createState() => _ScreenCreateProductsState();
}

class _ScreenCreateProductsState extends State<ScreenCreateProducts> {
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtPrice = TextEditingController();
  var txtSize = TextEditingController();
  
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
        title: const Text('Cadastrar produto'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(50, 62, 64, 1),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: formKey,
          autovalidateMode: autoValidation ? AutovalidateMode.always : AutovalidateMode.disabled,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center ,
            children: [
              textFieldGeneral('Nome', txtName, context),
              const SizedBox(height: 10,),
              textFieldGeneral('Descrição', txtDescription, context),
              const SizedBox(height: 10,),
              textFieldGeneral('Tamanho', txtSize, context),
              const SizedBox(height: 10,),
              textFieldNumberGeneral('Preço', txtPrice, context),
              
              const SizedBox(height: 50,),

              //buttonRegister(),
          ],),
        )
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}