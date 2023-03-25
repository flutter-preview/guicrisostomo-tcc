import 'package:flutter/material.dart';
import 'package:tcc/controller/firebase/products.dart';
import 'package:tcc/utils.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/dropDownButton.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';
import 'package:tcc/globals.dart' as globals;

import '../widget/customer/bottonNavigationCustomer.dart';

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
              TextFieldGeneral(
                label: 'Nome', 
                variavel: txtName,
                context: context, 
                keyboardType: TextInputType.name,
                ico: Icons.person,
                validator: (value) {
                  validatorString(value!);
                },
              ),

              const SizedBox(height: 10,),

              TextFieldGeneral(
                label: 'Descrição', 
                variavel: txtDescription,
                context: context, 
                keyboardType: TextInputType.multiline,
                ico: Icons.description_outlined,
                validator: (value) {
                  validatorString(value!);
                },
              ),

              const SizedBox(height: 10,),
              
              // DropDown(text: 'Tamanho', itemsDropDownButton: listSize, callback: (text) {
              //      setState((){
              //        sizeSelected = text;
              //      });
              //   }),

              // const SizedBox(height: 10,),

              // DropDown(text: 'Categoria', itemsDropDownButton: listCategory, callback: (text) {
              //      setState((){
              //        categorySelected = text;
              //      });
              //   }),

              const SizedBox(height: 10,),

              TextFieldGeneral(
                label: 'Preço', 
                variavel: txtPrice,
                context: context, 
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ico: Icons.attach_money,
                validator: (value) {
                  validatorNumber(value!);
                },
              ),

              const SizedBox(height: 10,),

              TextFieldGeneral(
                label: 'URL da imagem', 
                variavel: txtUrlImage,
                context: context, 
                keyboardType: TextInputType.url,
                ico: Icons.link_rounded,
                validator: (value) {
                  validatorString(value!);
                },
              ),

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