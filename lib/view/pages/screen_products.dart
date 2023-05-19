import 'package:flutter/material.dart';
import 'package:tcc/controller/postgres/Lists/products.dart';
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
    List<ProductItemList> list = [];
    await ProductsController().list(category, size, txtProd.text).then((value) {
      list = value;
    });

    return list;
  } 

  Future<void> getCategories() async {
    await ProductsController().listCategories().then((value) {
      globals.categoriesBusiness = value;
      globals.sizesCategoryBusiness = [];
    });
    
  }

  Future<void> getSize() async {
    await ProductsController().listSizes(globals.categorySelected).then((value) {
      globals.sizesCategoryBusiness = value;
    });
  }

  @override
  void initState() {
    super.initState();
    if (globals.categoriesBusiness.isEmpty) {
      getCategories().then((value) {
        setState(() {
          globals.categorySelected = globals.categoriesBusiness[0];

          if (widget.arguments != null) {
            globals.categorySelected = widget.arguments!.title;
          }
        });
      });
    } else {
      setState(() {
        if (widget.arguments != null) {
          globals.categorySelected = widget.arguments!.title;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('b');
    Future<Widget?> listProduct() async {
      List<Widget> listWidget = [];
      List<ProductItemList> list = [];

      if (globals.categoriesBusiness.isEmpty) {
        return const CircularProgressIndicator();
      }

      try {
        if (globals.sizesCategoryBusiness.isEmpty) {
          await getSize();
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
    }

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
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: globals.categoriesBusiness.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: button(
                        globals.categoriesBusiness[index],
                        0,
                        0,
                        null,
                        () {
                          setState(() {
                            globals.categorySelected = globals.categoriesBusiness[index];
                            globals.sizesCategoryBusiness = [];
                          });
                        },
                        true,
                        24,
                        globals.categorySelected == globals.categoriesBusiness[index] ? globals.primaryBlack : null,
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