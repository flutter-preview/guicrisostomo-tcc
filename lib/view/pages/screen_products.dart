import 'package:flutter/material.dart';
import 'package:tcc/controller/postgres/Lists/products.dart';
import 'package:tcc/model/ProductItemList.dart';
import 'package:tcc/model/standardSlideShow.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/view/widget/productItem.dart';
import 'package:tcc/view/widget/sectionVisible.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';
import 'package:tcc/globals.dart' as globals;

class ScreenProducts extends StatefulWidget {
  final SlideShow? arguments;

  const ScreenProducts({
    super.key,
    this.arguments,
  });

  @override
  State<ScreenProducts> createState() => _ScreenProductsState();
}

class _ScreenProductsState extends State<ScreenProducts> {

  var txtProd = TextEditingController();

  Future<List<ProductItemList>> getProduct(category, size) async {
    return await ProductsController().list(category, size, txtProd.text).then((value) {
      return value;
    });
  } 

  Future<List<String>> getCategories() async {
    globals.sizesCategoryBusiness = [];

    return await ProductsController().listCategories().then((value) {
      return value;
    });
  }

  Future<List<String>> getSize() async {
    return await ProductsController().listSizes(globals.categorySelected).then((value) {
      return value;
    });
  }

  @override
  void initState() {
    super.initState();
    if (globals.categoriesBusiness.isEmpty) {
      getCategories().then((value) {
        setState(() {
          globals.categoriesBusiness = value;

          globals.categorySelected = globals.categoriesBusiness[0];

          if (widget.arguments != null) {
            globals.categorySelected = widget.arguments!.title;
          }
        });
      });
    } else {
      if (widget.arguments != null) {
        setState(() {
          globals.categorySelected = widget.arguments!.title;
          globals.sizesCategoryBusiness = [];
        });
      }

      if (globals.categorySelected == '') {
        setState(() {
          globals.categorySelected = globals.categoriesBusiness[0];
        });
      }
    }
  }

  Future<Widget?> listProduct() async {
    List<Widget> listWidget = [];
    List<ProductItemList> list = [];

    if (globals.categoriesBusiness.isEmpty) {
      await getCategories().then((value) {
        globals.categoriesBusiness = value;
      });

      globals.sizesCategoryBusiness = [];
    }

    try {
      if (globals.sizesCategoryBusiness.isEmpty) {
        await getSize().then((value) {
          globals.sizesCategoryBusiness = value;
        });

        list = [];
      }

      if (list.isEmpty) {
        if (globals.sizesCategoryBusiness.length == 1) {
          await getProduct(globals.categorySelected, globals.sizesCategoryBusiness[0]).then((value) {
            listWidget.add(
              SectionVisible(
                nameSection: 'Produtos',
                isShowPart: true,
                child: ProductItem(product: value,),
              ),
            );

            list = value;
          });

        } else {
          for (int i = 0; i < globals.sizesCategoryBusiness.length; i++) {
            await getProduct(globals.categorySelected, globals.sizesCategoryBusiness[i]).then((value) {
              listWidget.add(
                SectionVisible(
                  nameSection: globals.sizesCategoryBusiness[i],
                  isShowPart: true,
                  child: ProductItem(product: value,),
                ),
              );

              list = value;
            });
          }
        }
      } else {
        if (globals.sizesCategoryBusiness.length == 1) {
          listWidget.add(
            SectionVisible(
              nameSection: 'Produtos',
              isShowPart: true,
              child: ProductItem(product: list,),
            ),
          );

        } else {
          for (int i = 0; i < globals.sizesCategoryBusiness.length; i++) {
            if (globals.sizesCategoryBusiness.length == 1) {
              await getProduct(globals.categorySelected, globals.sizesCategoryBusiness[0]).then((value) {
                listWidget.add(
                  SectionVisible(
                    nameSection: 'Produtos',
                    isShowPart: true,
                    child: ProductItem(product: value,),
                  ),
                );

                list = value;
              });

            } else {
              for (int i = 0; i < globals.sizesCategoryBusiness.length; i++) {
                listWidget.add(
                  SectionVisible(
                    nameSection: globals.sizesCategoryBusiness[i],
                    isShowPart: true,
                    child: ProductItem(product: list,),
                  ),
                );
              }
            }
          }
        }
      }

      if (listWidget.isNotEmpty) {
        return Column(
          children: listWidget,
        );
      }
    } catch (e) {
      return const Text(
        'Produto não encontrado',
        style: TextStyle(
          fontSize: 20,
          color: Colors.black45,
        ),
      );
    }
    return null;
  }

  IconData? getIconCategory(String category) {
    
    switch (category) {
      case 'PIZZA': case 'PIZZAS':
        return Icons.local_pizza;
      case 'SALGADO': case 'SALGADOS':
        return Icons.fastfood;
      case 'SUCO': case 'SUCOS':
        return Icons.local_bar_rounded;
      case 'REFRIGERANTE': case 'REFRIGERANTES': case 'BEBIDA': case 'BEBIDAS':
        return Icons.local_bar_rounded;
      case 'SANDUÍCHE': case 'SANDUÍCHES':
        return Icons.fastfood;
      case 'HAMBÚRGUER': case 'HAMBÚRGUERES': case 'CACHORRO-QUENTE': case 'CACHORROS-QUENTES':
        return Icons.lunch_dining_rounded;
      case 'SOBREMESA': case 'SOBREMESAS':
        return Icons.icecream;
      case 'LANCHE': case 'LANCHES':
        return Icons.lunch_dining_rounded;
      case 'COMIDA': case 'COMIDAS':
        return Icons.dinner_dining_rounded;
      default:
        return Icons.fastfood;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          pageName: 'Produtos',
          context: context,
          icon: Icons.restaurant_menu,
        ),
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
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 2,
                shrinkWrap: true,
                children: [
                  for (int i = 0; i < globals.categoriesBusiness.length; i++)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          globals.categorySelected = globals.categoriesBusiness[i];
                          globals.sizesCategoryBusiness = [];
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: globals.categorySelected == globals.categoriesBusiness[i] ? globals.primary : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: globals.categorySelected == globals.categoriesBusiness[i] ? globals.primary : Colors.black45,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                getIconCategory(globals.categoriesBusiness[i].toUpperCase()),
                                color: globals.categorySelected == globals.categoriesBusiness[i] ? Colors.white : globals.primary,
                              ),
                              Text(
                                globals.categoriesBusiness[i],
                                style: TextStyle(
                                  color: globals.categorySelected == globals.categoriesBusiness[i] ? Colors.white : Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ]
              ),
            ),

            const SizedBox(height: 20),

            FutureBuilder(
              future: listProduct(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == null) {
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
                  
                  return snapshot.data as Widget;
                } else if (snapshot.hasError) {
                  return const Text('Erro ao carregar os produtos');
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
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