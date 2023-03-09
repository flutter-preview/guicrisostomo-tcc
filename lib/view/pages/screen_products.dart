// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:tcc/controller/firebase/products.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigationCustomer.dart';
import 'package:tcc/view/widget/productItem.dart';
import 'package:tcc/view/widget/sectionVisible.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';

class ScreenProducts extends StatefulWidget {
  const ScreenProducts(Object arguments, {super.key});

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
      appBar: appBarWidget(
        pageName: 'Produtos',
        context: context,
        icon: Icons.restaurant_menu,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
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

            const SizedBox(height: 20),

            SectionVisible(
              nameSection: 'Tamanho',
              isShowPart: true,
              child: ProductItem(list),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
      
    );
  }
}