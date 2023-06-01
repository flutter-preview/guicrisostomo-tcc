import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tcc/controller/postgres/Lists/products.dart';
import 'package:tcc/model/ProductItemList.dart';
import 'package:tcc/model/standardSlideShow.dart';
import 'package:tcc/utils.dart';
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

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  Future<List<ProductItemList>> getProduct(category, size) async {
    return await ProductsController.instance.list(category, size, txtProd.text).then((value) {
      return value;
    });
  } 

  Future<List<String>> getCategories() async {
    globals.sizesCategoryBusiness = [];

    return await ProductsController.instance.listCategories().then((value) {
      return value;
    });
  }

  Future<List<String>> getSize() async {
    return await ProductsController.instance.listSizes(globals.categorySelected).then((value) {
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
      print(e);
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _key,
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

                        getSize().then((value) {
                          setState(() {
                            globals.sizesCategoryBusiness = value;
                          });

                          if (globals.sizesCategoryBusiness.length > 1) {
                            _key.currentState!.openDrawer();
                          }
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,

                                children: [
                                  Text(
                                    globals.categoriesBusiness[i],
                                    style: TextStyle(
                                      color: globals.categorySelected == globals.categoriesBusiness[i] ? Colors.white : Colors.black45,
                                    ),
                                  ),

                                  const SizedBox(width: 5,),

                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 15,
                                    color: globals.categorySelected == globals.categoriesBusiness[i] ? Colors.white : Colors.black45,
                                  )
                                ],
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
      
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            
            children: [
              const Text(
                'Tamanho',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),
        
              FutureBuilder(
                future: Future.value(globals.sizesCategoryBusiness),
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
                    
                    return GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
        
                      children: [
                        GestureDetector(
                          onTap: () {
                            _key.currentState!.closeDrawer();
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: globals.sizesCategoryBusiness.isEmpty ? globals.primary : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: globals.sizesCategoryBusiness.isEmpty ? globals.primary : globals.primary.withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Todos',
                                style: TextStyle(
                                  color: globals.sizesCategoryBusiness.isEmpty ? Colors.white : globals.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
        
                        for (int i = 0; i < snapshot.data!.length; i++)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                globals.sizesCategoryBusiness = [snapshot.data![i]];
                              });
        
                              _key.currentState!.closeDrawer();
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: globals.sizesCategoryBusiness.contains(snapshot.data![i]) ? globals.primary : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: globals.sizesCategoryBusiness.contains(snapshot.data![i]) ? globals.primary : Colors.black45,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  snapshot.data![i],
                                  style: TextStyle(
                                    color: globals.sizesCategoryBusiness.contains(snapshot.data![i]) ? Colors.white : Colors.black45,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ]
                    );
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
      ),
    );
  }
}