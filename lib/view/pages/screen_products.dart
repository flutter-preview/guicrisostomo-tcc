// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:tcc/controller/mysql/Lists/products.dart';
import 'package:tcc/model/ProductItemList.dart';
import 'package:tcc/model/standardSlideShow.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/productItem.dart';
import 'package:tcc/view/widget/sectionVisible.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';
import 'package:tcc/globals.dart' as globals;

class ScreenProducts extends StatefulWidget {
  Object? arguments;

  ScreenProducts({
    super.key,
    this.arguments,
  });

  @override
  State<ScreenProducts> createState() => _ScreenProductsState();
}

class _ScreenProductsState extends State<ScreenProducts> {
  String categorySelected = 'Pizzas';

  var txtProd = TextEditingController();
  
  List<String> categories = [
    'Pizzas',
    'Comidas',
    'Bebidas',
    'Lanches',
    'Salgados',
    'Doces',
    'Sobremesas',
    'Outros',
  ];

  List<ProductItemList> list = [];


  void getProduct() async {
    await ProductsController().list().then((value) {
      setState(() {
        list = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {

    dynamic categorySelect = widget.arguments != null ? widget.arguments as SlideShow : SlideShow(path: '', title: '', onTap: () {});
    categorySelected = widget.arguments != null ? categorySelect.title : categorySelected;
    
    if (list.isEmpty) {
      getProduct();
    }
    
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

            const SizedBox(height: 10),

            SectionVisible(
              nameSection: 'Categorias',
              isShowPart: true,
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: button(
                        categories[index],
                        0,
                        0,
                        null,
                        () {
                          setState(() {
                            categorySelected = categories[index];
                          });
                        },
                        true,
                        24,
                        categorySelected == categories[index] ? globals.primaryBlack : null,
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            SectionVisible(
              nameSection: 'Tamanho',
              isShowPart: true,
              child: ProductItem(
                product: list,
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
      
    );
  }
}