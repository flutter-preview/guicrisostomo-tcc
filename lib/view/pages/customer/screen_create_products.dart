import 'package:flutter/material.dart';
import 'package:tcc/controller/firebase/products.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/dropDownButton.dart';
import 'package:tcc/view/widget/textField.dart';
import 'package:tcc/view/widget/textFieldNumberGeneral.dart';
import 'package:tcc/globals.dart' as globals;

import '../../widget/bottonNavigationCustomer.dart';

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
  var txtUrlImage = TextEditingController();
  
  var formKey = GlobalKey<FormState>();

  bool autoValidation = false;
  String sizeSelected = '';
  String categorySelected = '';

  @override
  void initState() {
    autoValidation = false;
    super.initState();
  }

  List <String> listSize = [
    'PEQUENA',
    'GRANDE',
    'GIGANTE',
  ];

  List <String> listCategory = [
    'PIZZA',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar produto'),
        centerTitle: true,
        backgroundColor: globals.primary,
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
              
              DropDown(text: 'Tamanho', itemsDropDownButton: listSize, callback: (text) {
                   setState((){
                     sizeSelected = text;
                   });
                }),

              const SizedBox(height: 10,),

              DropDown(text: 'Categoria', itemsDropDownButton: listCategory, callback: (text) {
                   setState((){
                     categorySelected = text;
                   });
                }),

              const SizedBox(height: 10,),

              textFieldNumberGeneral('Preço', txtPrice, context),

              const SizedBox(height: 10,),
              
              textFieldGeneral('URL da imagem', txtUrlImage, context),

              const SizedBox(height: 50,),

              button('Salvar', 100, 50, Icons.add, () {

                if (formKey.currentState!.validate()) {
        
                  ProductsController().add(txtName.text, num.parse(txtPrice.text.replaceFirst(',', '.')), txtDescription.text, categorySelected, sizeSelected, txtUrlImage.text);

                } else {
                  setState(() {
                    autoValidation = true;
                  });
                }

              })
          ],),
        )
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}