import 'package:flutter/material.dart';
import 'package:tcc/controller/mysql/Lists/products.dart';
import 'package:tcc/model/ProductItemList.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/productItem.dart';
import 'package:tcc/view/widget/sectionVisible.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';
import 'package:tcc/globals.dart' as globals;

class ScreenProducts extends StatefulWidget {
  final Object? arguments;

  const ScreenProducts({
    super.key,
    this.arguments,
  });

  @override
  State<ScreenProducts> createState() => _ScreenProductsState();
}

class _ScreenProductsState extends State<ScreenProducts> {
  
  String categorySelected = 'Pizzas';

  var txtProd = TextEditingController();
  
  List<String> categories = [];
  List<String> sizes = [];

  Future<List<ProductItemList>> getProduct(category, size) async {
    List<ProductItemList> list = [];
    await ProductsController().list(category, size, txtProd.text).then((value) {
      list = value;
    });

    return list;
  } 

  void getCategories() async {
    await ProductsController().listCategories().then((value) {
      setState(() {
        categories = value;
      });
    });
    
  }

  void getSize() async {
    await ProductsController().listSizes(categorySelected).then((value) {
      setState(() {
        sizes = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    
    if (categories.isEmpty) {
      getCategories();
    }

    print(DateTime.now().toUtc());

    Future<Widget> listProduct() async {
      List<Widget> listWidget = [];
      List<ProductItemList> list = [];
      list.clear();

      try {
        if (sizes.isEmpty) {
          getSize();
        }

        if (list.isEmpty) {
          if (sizes.length == 1) {
            await getProduct(categorySelected, sizes[0]).then((value) {
              listWidget.add(
                SectionVisible(
                  nameSection: 'Produtos',
                  isShowPart: true,
                  child: SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: ProductItem(product: list,),
                  ),
                ),
              );
            });

          } else {
            for (int i = 0; i < sizes.length; i++) {
              await getProduct(categorySelected, sizes[i]).then((value) {
                listWidget.add(
                  SectionVisible(
                    nameSection: sizes[i],
                    isShowPart: true,
                    child: SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: ProductItem(product: value,),
                    ),
                  ),
                );
              });
            }
          }
        }

        if (listWidget.isNotEmpty) {
          return Column(
            children: listWidget,
          );
        } else {
          return const SizedBox(
            height: 50,
            child: Text(
              'Produto não encontrado',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black45,
              ),
            ),
          );
        }
      } catch (e) {
        return const SizedBox(
          height: 50,
          child: Text(
            'Produto não encontrado',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black45,
            ),
          ),
        );
      }
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

            FutureBuilder(
              future: listProduct(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data as Widget;
                } else {
                  return const SizedBox(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
      
    );
  }
}