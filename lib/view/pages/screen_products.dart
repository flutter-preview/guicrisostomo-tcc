// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:tcc/controller/firebase/products.dart';
import 'package:tcc/view/widget/bottonNavigationCustomer.dart';
import 'package:tcc/view/widget/floatingButton.dart';
import 'package:tcc/view/widget/productItem.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/textFieldGeneral.dart';

class ScreenProducts extends StatefulWidget {
  const ScreenProducts({super.key});

  @override
  State<ScreenProducts> createState() => _ScreenProductsState();
}

class _ScreenProductsState extends State<ScreenProducts> {
  var txtProd = TextEditingController();

  var list;

  @override
  void initState() {
    super.initState();
    list = ProductsController().list();
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: Column(
          children: [

            TextFieldGeneral(
              label: 'Procurar item',
              variavel: txtProd,
              context: context,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                setState(() {
                  list = ProductsController().listSearch(value);
                });
              },

              icoSuffix: Icons.search,
              angleSufixIcon: 90 * 3.14 / 180,
            ),
            
            ProductItem(list),
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
      floatingActionButton: floatingButton(context),
    );
  }
}