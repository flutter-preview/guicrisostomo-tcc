import 'package:flutter/material.dart';
import 'package:tcc/view/widget/dropDownButton.dart';
import 'package:tcc/view/widget/textField.dart';
import 'package:tcc/view/widget/textFieldNumberGeneral.dart';

import '../widget/bottonNavigationCustomer.dart';

class ScreenCreateOrder extends StatefulWidget {
  const ScreenCreateOrder({super.key});

  @override
  State<ScreenCreateOrder> createState() => _ScreenCreateOrderState();
}

class _ScreenCreateOrderState extends State<ScreenCreateOrder> {
  var txtTypeSale = TextEditingController();
  var txtWaiter = TextEditingController();
  var txtTotal = TextEditingController();
  var txtTypePayment = TextEditingController();
  
  var formKey = GlobalKey<FormState>();

  bool autoValidation = false;

  @override
  void initState() {
    autoValidation = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List <String> listTypeSale = [
      'Retirada',
      'Entrega',
      'Mesa',
    ];

    List <String> listWaiter = [
      'Ana',
      'João',
      'Fatima',
    ];

    List <String> listTypePayment = [
      'Dinheiro',
      'Cartão',
      'Pix',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar pedido'),
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
              DropDown(text: 'Selecione o tipo de venda', itemsDropDownButton: listTypeSale),
              const SizedBox(height: 10,),
              DropDown(text: 'Selecione o atendente', itemsDropDownButton: listWaiter),
              const SizedBox(height: 10,),
              DropDown(text: 'Selecione a forma de pagamento', itemsDropDownButton: listTypePayment),
              const SizedBox(height: 10,),
              textFieldNumberGeneral('Preço', txtTotal, context),
              
              const SizedBox(height: 50,),
          ],),
        )
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}