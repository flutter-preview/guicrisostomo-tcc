import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tcc/controller/mysql/Lists/businessInfo.dart';
import 'package:tcc/controller/mysql/Lists/products.dart';
import 'package:tcc/controller/mysql/Lists/productsCart.dart';
import 'package:tcc/controller/mysql/Lists/sales.dart';
import 'package:tcc/main.dart';
import 'package:tcc/model/ProductItemList.dart';
import 'package:tcc/model/ProductsCart.dart';
import 'package:tcc/model/StandardCheckBox.dart';
import 'package:tcc/model/Variation.dart';
import 'package:tcc/model/standardListDropDown.dart';
import 'package:tcc/model/standardRadioButton.dart';
import 'package:tcc/utils.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/checkBox.dart';
import 'package:tcc/view/widget/dropDownButton.dart';
import 'package:tcc/view/widget/radioButton.dart';
import 'package:tcc/view/widget/sectionVisible.dart';
import 'package:tcc/view/widget/snackBars.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/switchListTile.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';

class ScreenAddItem extends StatefulWidget {
  Object? arguments;

  ScreenAddItem({
    super.key,
    this.arguments,
  });

  @override
  State<ScreenAddItem> createState() => _ScreenAddItemState();
}

class _ScreenAddItemState extends State<ScreenAddItem> {
  var formKey = GlobalKey<FormState>();
  bool autoValidation = false;

  num subTotal = 0;
  List<ProductsCartList> items = [];
  List<Variation> variations = [];
  List<Future<Widget>> listWidgetVariation = [];

  var txtQtd = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    autoValidation = false;
    txtQtd.text = "1";
  }

  @override
  Widget build(BuildContext context) {
    ProductItemList productSelect = widget.arguments as ProductItemList;
    
    int idProduct = productSelect.id;
    String nameProduct = productSelect.name;
    num priceProduct = productSelect.price;
    String descriptionProduct = productSelect.description!;
    String? urlImageProduct = productSelect.link_image;
    Variation variation = productSelect.variation!;
    int idVariation = variation.id ?? 0;

    Widget constructorWidgetSepareItemsText(Variation variation, String separator, int idText) {
      TextEditingController textController = variation.getTextController(idText);
      String text = textController.text;
      List<String> items = text.split(separator);

      return StatefulBuilder(
        builder: (context, setState) {
          return SizedBox(
            height: 50,
            width: double.infinity,
            child: ListView.builder(
              itemCount: items.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [
                      globals.primary,
                      globals.primaryBlack,
                    ])
                  ),
          
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(5),
          
                  child: Row(
                    children: [
                      Text(
                        items[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(width: 5),

                      InkWell(
                        onTap: () {
                          setState(() {
                            items.removeAt(index);
                          
                            text = items.join(separator);
                          
                            textController.selection = TextSelection.fromPosition(
                              TextPosition(offset: text.length)
                            );
                          });
                          
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                );
              }
            ),
          );
        }
      );
    }

    Future<Widget> addWidgetVariation(Variation element) async {
      List<DropDownList> itemsDropDownButton = [];
      List<RadioButtonList> itemsRadioListTile = [];
      List<CheckBoxList> itemsCheckBoxListTile = [];
      
      if (element.isDropDown != null) {
        if (element.isDropDown == true) {
          itemsDropDownButton.add(
            DropDownList(
              name: "Não quero ${element.category.toLowerCase()}",
              icon: Icons.shopping_cart,
            )
          );

          await ProductsController().list(element.category, element.size, '').then((List<ProductItemList> res) {
            
            if (res.isNotEmpty) {
              for (final ProductItemList item in res) {
                itemsDropDownButton.add(
                  DropDownList(
                    name: item.name,
                    icon: Icons.shopping_cart,
                  )
                );
              }
            }
          });
        } else {
          if (element.limitItems == 1) {
            itemsRadioListTile.add(
              RadioButtonList(
                name: "Não quero ${element.category.toLowerCase()}",
                icon: Icons.shopping_cart,
              )
            );

            await ProductsController().list(element.category, element.size!, '').then((List<ProductItemList> res) {
              if (res.isNotEmpty) {
                for (final ProductItemList item in res) {
                  itemsRadioListTile.add(
                    RadioButtonList(
                      name: item.name,
                      icon: Icons.shopping_cart,
                    )
                  );
                }
              }
            });
          } else {
            await ProductsController().list(element.category, element.size, '').then((List<ProductItemList> res) {
              if (res.isNotEmpty) {
                for (final ProductItemList item in res) {
                  itemsCheckBoxListTile.add(
                    CheckBoxList(
                      value: item.name,
                    )
                  );
                }
              }
            });
          }
          
        }
      }

      return SectionVisible(
        nameSection: element.category, 
        isShowPart: true,
        child: (element.isDropDown == null) ?
          await ProductsController().list(element.category, element.size, '').then((List<ProductItemList> res) {
            List<Widget> listWidgetTextEditing = [];

            if (res.isNotEmpty) {
              for (final ProductItemList item in res) {
                element.addValue(item.id);

                listWidgetTextEditing.add(
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        children: [
                          TextFieldGeneral(
                            variavel: element.getTextController(item.id),
                            keyboardType: TextInputType.text,
                            label: "Digite o nome do ${item.name.toLowerCase()}",
                            validator: (value) {
                              return validatorString(value!);
                            },
                            onChanged: (value) {
                                
                              setState(() {
                                
                              // //   // element.isTextEmpty = !element.isTextEmpty;
                              // //   // element.setValues(element.category, value);
                                if (value == "" || value.isEmpty) {
                                  element.isTextEmpty[item.id] = true;
                                } else {
                                  element.isTextEmpty[item.id] = false;
                                }

                                // element.checkTextEmpty(item.id);
                              });
                            },
                            // key: Key(element.category),
                            context: context,
                          ),

                          const SizedBox(height: 10),

                          if (element.pricePerItem == true)
                            Column(
                              children: [
                                Text(
                                  "Será cobrado R\$ ${item.price.toStringAsFixed(2)} por ${element.category.toLowerCase()}! Por favor, separe os itens por vírgula",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: globals.primary
                                  ),
                                ),

                                const SizedBox(height: 10),

                                element.isTextEmpty[item.id] == false ?
                                  constructorWidgetSepareItemsText(element, ',', item.id)
                                :
                                  Container(),
                              ],
                            ),
              
                          SwitchListTileWidget(
                            title: Text(
                              "Quero ${element.category.toLowerCase()} ${item.name.toLowerCase()}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            value: !element.isTextEmpty.values.toList()[element.isTextEmpty.keys.toList().indexOf(item.id)],
                            privateValue: true,
                            onChanged: (value) {
                              setState(() {
                                element.setValues(value ? element.getValues(item.id) : "", item.id);
                              });
                            },
                          )
                        ],
                      );
                    }
                  )
                );
              }

              return Column(
                children: listWidgetTextEditing,
              );
            } else {
              return const SizedBox();
            }
          })
          
        : element.isDropDown == true ?
          DropDown(
            text: element.category,
            itemsDropDownButton: itemsDropDownButton,
            variavel: null,
            callback: (value) {
              setState(() {
                element.setValues(value);
              });
            },
          )
        :
          (element.limitItems == 1) ?
            RadioButon(
              list: itemsRadioListTile,
            )
          :
            CheckBoxWidget(
              list: itemsCheckBoxListTile,
              limitCheck: element.limitItems ?? 0,
            )
      );
    }

    Future<void> listItemsMain() async {
      await BusinessInformationController().getInfoCalcValue().then((isHighValue) async {
        await SalesController().idSale().then((idOrder) async {
          await ProductsCartController().listItemCurrent(idOrder, idProduct == 0 ? await ProductsCartController().getVariationItem(idOrder) : idVariation).then((List<ProductsCartList> res) {
            subTotal = productSelect.price;
            items.clear();
            
            if (res.isNotEmpty) {
              bool value = isHighValue ?? false;

              for (final ProductsCartList item in res) {
                num price = item.price!;
                if (isHighValue ?? true) {
                  if (subTotal < price) {
                    subTotal = price;
                  }
                } else {
                  subTotal += price;
                }

                items.add(item);
              }

              if (!value) {
                subTotal /= res.length;
              }
            }
          });
        });
      });
    }

    Future<void> listItemsVariations() async {
      listWidgetVariation.clear();
      return await ProductsController().listVariations(idVariation).then((List<Variation> res) {
        if (res.isNotEmpty) {
          for (final Variation item in res) {
            variations.add(item);
            listWidgetVariation.add(addWidgetVariation(item));
            
          }
        }
      });
    }
    
    Future<void> getList() async {
      
      await listItemsMain();
      await listItemsVariations();

      setState(() {});
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        
        child: AppBar(
          titleSpacing: 0,
          title: const Flexible(
            child: Text(
              'Adicionar ao carrinho',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),

          flexibleSpace: CachedNetworkImage(
            imageUrl: urlImageProduct ?? 'https://lh5.googleusercontent.com/p/AF1QipOBoD7baOHV4zR4Do0NrU7Vsi75ZTRM4eq9UgmL=s443-k-no',
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            imageBuilder: (context, image) {
              return Container(
                alignment: Alignment.centerLeft,
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                    image: image,
                    fit: BoxFit.cover,
                  ),
                ),
              
                child: Wrap(
                  direction: Axis.horizontal,
                  children: [
                    
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            idProduct == 0 ? 'Adicionar items ao carrinho' : nameProduct,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          
                          idProduct == 0 ? 
                            Container() :
                            Text(
                              'R\$ ${priceProduct.toStringAsFixed(2).replaceFirst('.', ',')}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                        ]
                      ),
                    ),
                  ]
                )
              );
            }
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: FutureBuilder(
          future: subTotal == 0 ? getList() : null,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                autovalidateMode: autoValidation ? AutovalidateMode.always : AutovalidateMode.disabled,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    idProduct != 0 ?
                      Row(
                        children: [
                          Icon(
                            Icons.description,
                            color: globals.primary,
                            size: 30,
                          ),

                          const SizedBox(width: 10),

                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Descição: $descriptionProduct',
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ) : Container(),

                    const SizedBox(height: 20),

                    idProduct != 0 ?
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: globals.primary, spreadRadius: 1),
                          ],
                        ),

                        height: 85,
                        width: MediaQuery.of(context).size.width - 20,
                        child: Padding(
                          padding: const EdgeInsets.all(10),

                          child: ElevatedButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              Navigator.push(context, navigator('products'));
                              
                              setState(() {
                                globals.isSelectNewItem = true;
                              });

                              await SalesController().idSale().then((res) async {
                                await ProductsCartController().add(res, idProduct, nameProduct, int.parse(txtQtd.text), idVariation);
                              });
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.black,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),

                            child: Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  color: globals.primary,
                                  size: 30,
                                ),
                                            
                                const SizedBox(width: 10),
                                            
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Agregar outro item ao produto',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ) : Container(),

                    const SizedBox(height: 10),

                    SectionVisible(
                      nameSection: 'Itens do produto', 
                      isShowPart: true,
                      child: FutureBuilder(
                        future: items.isEmpty ? getList() : null,
                        builder: (context, snapshot) {
                          return Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: items.length,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: globals.primary,
                                        ),

                                        margin: const EdgeInsets.only(bottom: 10),

                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                              
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.min,

                                            children: [
                                              Flexible(
                                                child: Text(
                                                  items[index].name!,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),

                                              Row(
                                                children: [
                                                  Text(
                                                    'R\$ ${items[index].price?.toStringAsFixed(2).replaceFirst('.', ',')}',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                              
                                                  const SizedBox(width: 10),
                              
                                                  IconButton(
                                                    onPressed: () async {
                                                      ProductsCartController().remove(items[index].id!, context);
                                                      getList();
                                                    },
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  );
                                },
                              )
                            ],
                          );
                        }
                      ),
                    ),

                    const SizedBox(height: 20),
              
                    Padding(
                      padding: const EdgeInsets.only(bottom: 80),
                      child: Column(
                        children: [

                          listWidgetVariation.isNotEmpty ?
                            Column(
                              children: List.generate(
                                listWidgetVariation.length,
                                (index) {
                                  return FutureBuilder(
                                    future: listWidgetVariation[index],
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return snapshot.data!;
                                      } else if (snapshot.hasError) {
                                        return Text('${snapshot.error}');
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  );
                                }
                              )
                            )
                          : Container(),

                          const SizedBox(height: 20),

                          Container(
                            alignment: Alignment.bottomLeft,
                            height: 80,
                            width: MediaQuery.of(context).size.width,
                            child: TextFieldGeneral(
                              label: 'Quantidade', 
                              variavel: txtQtd,
                              context: context, 
                              keyboardType: TextInputType.number,
                              ico: Icons.shopping_cart_outlined,
                              validator: (value) {
                                validatorNumber(value!);
                              },
                              onChanged: (value) {
                                subTotal *= int.parse(value);
                              },
                            ),
                          ),

                          const SizedBox(height: 20),

                          FutureBuilder(
                            future: subTotal != 0 ? Future.value(true) : Future.value(false),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.done) {
                                return Container(
                                  alignment: Alignment.bottomRight,
                                  height: 60,
                                  child: button('Adicionar R\$ ${subTotal.toStringAsFixed(2).replaceFirst('.', ',')}', 100, 50, Icons.add_shopping_cart, () async {
                                    if (formKey.currentState!.validate()) {
                                      int idSale;
                                      await SalesController().idSale().then((res) async {
                                        idSale = res;
                                        await ProductsCartController().add(idSale, idProduct, nameProduct, int.parse(txtQtd.text), idVariation, false);
                
                                        await SalesController().getTotal().then((res){
                                          // SalesController().updateTotal(idSale, res + subTotal);
                                          Navigator.pop(context);
                                          success(context, 'Produto adicionado com sucesso');
                                        }).catchError((e){
                                          error(context, 'Ocorreu um erro ao adicionar o produto: $e');
                                          
                                        });
                
                                      }).catchError((e){
                                        error(context, 'Ocorreu um erro ao adicionar o produto: $e');
                                        print(e);
                                      });
                
                                    } else {
                                      setState(() {
                                        autoValidation = true;
                                      });
                                    }
                                  }),
                                );
                              } else if (snapshot.connectionState == ConnectionState.waiting) {
                                return Container(
                                  alignment: Alignment.bottomRight,
                                  height: 60,
                                  child: button('Adicionar R\$ ${subTotal.toStringAsFixed(2).replaceFirst('.', ',')}', 100, 50, Icons.add_shopping_cart, () async {
                                    
                                  }),
                                );
                              } else {
                                return const Center(
                                  child: Text('Ocorreu um erro ao carregar os dados'),
                                );
                              }
                            },
                          )
      
                          
                        ]
                      ),
                    )
                  ]
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}