import 'package:flutter/material.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/dropDownButton.dart';
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
  String? typeSaleSelected;
  String? typePaymentSelected;
  String? waiterSelected;

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
              DropDown(text: 'Selecione o tipo de venda', itemsDropDownButton: listTypeSale, callback: (text) {
                   setState((){
                     typeSaleSelected = text;
                   });
                }),
              const SizedBox(height: 10,),
              DropDown(text: 'Selecione o atendente', itemsDropDownButton: listWaiter, callback: (text) {
                   setState((){
                     waiterSelected = text;
                   });
                }),
              const SizedBox(height: 10,),
              DropDown(text: 'Selecione a forma de pagamento', itemsDropDownButton: listTypePayment,  callback: (text) {
                   setState((){
                     typePaymentSelected = text;
                   });
                }),
              const SizedBox(height: 10,),
              textFieldNumberGeneral('Preço', txtTotal, context),
              
              const SizedBox(height: 50,),

              button('Salvar', 100, 50, () {
                Navigator.popAndPushNamed(context, 'home');
              })
          ],),
        )
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}