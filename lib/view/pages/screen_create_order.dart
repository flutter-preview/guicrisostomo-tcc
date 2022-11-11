import 'package:flutter/material.dart';
import 'package:tcc/view/widget/textField.dart';
import 'package:tcc/view/widget/textFieldNumberGeneral.dart';

class ScreenCreateOrder extends StatefulWidget {
  const ScreenCreateOrder({super.key});

  @override
  State<ScreenCreateOrder> createState() => _ScreenCreateOrderState();
}

class _ScreenCreateOrderState extends State<ScreenCreateOrder> {
  var txtTypeSale = TextEditingController();
  var txtWaiter = TextEditingController();
  var txtPrice = TextEditingController();
  var txtSize = TextEditingController();

  final String imgRegister = 'lib/images/imgRegister.svg';
  
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
    );
  }
}