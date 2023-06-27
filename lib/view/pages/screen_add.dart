import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tcc/controller/postgres/Lists/businessInfo.dart';
import 'package:tcc/controller/postgres/Lists/products.dart';
import 'package:tcc/controller/postgres/Lists/productsCart.dart';
import 'package:tcc/controller/postgres/Lists/sales.dart';
import 'package:tcc/model/ProductItemList.dart';
import 'package:tcc/model/ProductsCart.dart';
import 'package:tcc/model/StandardCheckBox.dart';
import 'package:tcc/model/Variation.dart';
import 'package:tcc/model/standardListDropDown.dart';
import 'package:tcc/model/standardRadioButton.dart';
import 'package:tcc/utils.dart';
import 'package:tcc/validators.dart';
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
  final Object? arguments;

  const ScreenAddItem({
    super.key,
    this.arguments,
  });

  @override
  State<ScreenAddItem> createState() => _ScreenAddItemState();
}

class _ScreenAddItemState extends State<ScreenAddItem> {
  var formKey = GlobalKey<FormState>();
  bool autoValidation = false;
  bool isBusinessHighValue = false;

  num subTotal = 0;
  num saveSubTotal = 0;
  int t = 0;
  List<ProductsCartList> items = [];
  List<Variation> variations = [];
  List<Widget> listWidgetVariation = [];
  List<Widget> subVariations = <Widget>[];

  List<DropDownList> itemsDropDownButton = [];
  List<RadioButtonList> itemsRadioListTile = [];
  List<CheckBoxList> itemsCheckBoxListTile = [];

  ProductItemList productSelect = ProductItemList(
    id: 0,
    name: '',
    price: 0,
    description: '',
    linkImage: '',
    variation: Variation(
      id: 0,
      category: '',
      size: '',
      isDropDown: false,
      limitItems: 0,
      pricePerItem: false,
      price: 0.0,
      idSubVariation: 0,
    ),
    isFavorite: false,
  );

  var txtQtd = TextEditingController();
  var txtObservation = TextEditingController();
  
  int idProduct = 0;
  String nameProduct = '';
  num priceProduct = 0;
  String? descriptionProduct;
  String? urlImageProduct;
  Variation variation = Variation(
    id: 0,
    category: '',
    size: '',
    isDropDown: false,
    limitItems: 0,
    pricePerItem: false,
    price: 0.0,
    idSubVariation: 0,
  );
  int idVariation = 0;

  @override
  void initState() {
    super.initState();
    productSelect = widget.arguments as ProductItemList;
    idProduct = productSelect.id;
    txtQtd.text = "1";

    if (idProduct != 0) {
      ProductsCartController.instance.verifyItemSelected(context, productSelect).whenComplete(() {
        GoRouter.of(context).pop();
      });
    }

    autoValidation = false;
    t = 0;

    nameProduct = productSelect.name;
    priceProduct = productSelect.price;
    descriptionProduct = productSelect.description;
    urlImageProduct = productSelect.linkImage;
    variation = productSelect.variation!;
    idVariation = variation.id ?? 0;

    ProductsController.instance.getSizesAndDifferencePriceProducts(priceProduct, nameProduct, idVariation);
  }

  void resetSubTotal() {
    setState(() {
      subTotal = 0;
    });
  }

  num calcVariations() {
    
    num total = 0;
    num saveTotal = 0;

    for (final Variation item in variations) {

      saveTotal = total;

      total += item.price;

      if (total.isNaN) {
        total = saveTotal;
      }

      item.productItemSelected.forEach((key, bool value) {
        if (value) {
          total += key.price;
        }
      });

      for (final Variation subItem in item.subVariation) {
        if (item.value == subItem.category) {
          total += subItem.getPriceTotal(isBusinessHighValue);
        }
      }

    }

    return total;
  }

  void calcSubTotal() {
    subTotal = saveSubTotal;

    setState(() {
      subTotal += calcVariations();
    
      subTotal *= int.parse(txtQtd.text);
    });
  }

  Widget constructorWidgetSepareItemsText(Variation variation, String separator, ProductItemList item) {
    TextEditingController textController = variation.getTextController(item.id);
    String text = textController.text;
    List<String> items = text.split(separator);
    variation.price = (items.length) * item.price;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) {
        resetSubTotal();
      }
    });

    return StatefulBuilder(
      builder: (context, setState) {
        

        return SizedBox(
          height: 50,
          width: double.infinity,
          child: ListView.builder(
            itemCount: items.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
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
                          textController.text = items.join(separator);
                          variation.setValues(textController.text, item.id);
                        
                          textController.selection = TextSelection.fromPosition(
                            TextPosition(offset: textController.text.length)
                          );
        
                          variation.price = (items.length) * item.price;
        
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (!context.mounted) {
                              resetSubTotal();
                            }
                          });
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

  Future<bool> getInfoVariation(Variation element) async {
    itemsDropDownButton = [];
    itemsRadioListTile = [];
    itemsCheckBoxListTile = [];
    element.productItemSelected = {};

    if (element.isDropDown != null) {
      if (element.isDropDown == true) {
        itemsDropDownButton.add(
          DropDownList(
            name: "Não quero ${element.category.toLowerCase()}",
            icon: Icons.shopping_cart,
          )
        );

        await ProductsController.instance.list(element.category, element.size, '').then((List<ProductItemList> res) {
          if (res.isNotEmpty) {
            for (final ProductItemList item in res) {
              element.addProductItem(item);
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

          await ProductsController.instance.list(element.category, element.size, '').then((List<ProductItemList> res) {
            if (res.isNotEmpty) {
              for (final ProductItemList item in res) {
                element.addProductItem(item);
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
          await ProductsController.instance.list(element.category, element.size, '').then((List<ProductItemList> res) {
            if (res.isNotEmpty) {
              for (final ProductItemList item in res) {
                element.addProductItem(item);
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

    element.setProductItemSelected();

    return true;
  }

  Future<Widget> putTextBoxVariation(Variation element) async {
    return await ProductsController.instance.list(element.category, element.size, '').then((List<ProductItemList> res) {
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
                      onChanged: (value) {
                          
                        setState(() {
                          
                        // //   // element.isTextEmpty = !element.isTextEmpty;
                        // //   // element.setValues(element.category, value);
                          if (value == "" || value.isEmpty) {
                            element.isTextEmpty[item.id] = true;
                          } else {
                            element.isTextEmpty[item.id] = false;
                          }

                          element.price = (value.split(',').length) * item.price;
                          // if (value.endsWith(',')) {
                          //   element.price += item.price;
                          // }

                          if (value == "") {
                            element.price = 0;
                          }

                          resetSubTotal();
                          
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
                            constructorWidgetSepareItemsText(element, ',', item)
                          :
                            Container(),
                        ],
                      ),
        
                    SwitchListTileWidget(
                      title: Text(
                        "Quero ${element.category.toLowerCase()} ${item.name.toLowerCase()}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      value: !element.isTextEmpty.values.toList()[element.isTextEmpty.keys.toList().indexOf(item.id)],
                      privateValue: true,
                      onChanged: (value) {
                        setState(() {
                          element.setValues(value ? element.getValues(item.id) : "", item.id);

                          if (!value) {
                            element.price = 0;
                          }
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
    });
  }

  Widget putDropDownVariation(Variation element) {
    if (element.value == '') {
      element.setValues("Não quero ${element.category.toLowerCase()}");
    }
    
    return StatefulBuilder(
      builder: (context, setState) {
        return DropDown(
          text: element.category,
          itemsDropDownButton: itemsDropDownButton,
          variavel: element.value,
          callback: (value) {
            setState(() {
              element.setValues(value);
              element.setProductItemSelected(value!, null, isBusinessHighValue);
              subTotal = 0;
            });
          },
        );
      }
    );
  }

  Widget putLimitElementVariation(Variation element) {
    return (element.limitItems == 1) ?
      RadioButon(
        list: itemsRadioListTile,
        callback: (value) {
          setState(() {
            element.setValues(value);
            element.setProductItemSelected(value!, true, isBusinessHighValue);
            subTotal = 0;
          });
        },
      )
    :
      CheckBoxWidget(
        list: itemsCheckBoxListTile,
        limitCheck: element.limitItems ?? 0,
        onChanged: (value, bool check) {
          setState(() {
            element.setValues(value);
            element.setProductItemSelected(value, check,
            isBusinessHighValue);
            subTotal = 0;
          });
        },
      );
  }

  Future<Widget> addWidgetVariation(Variation element) async {
    
    return Column(
      children: [
        await ProductsController.instance.listVariations(element.id!).then((List<Variation> res) async {
          subVariations = [];
          List<DropDownList> subVariationDropDownButton = [
            DropDownList(
              name: "Não quero ${element.category.toLowerCase()}",
              icon: Icons.category,
            )
          ];
          List<RadioButtonList> subVariationRadioListTile = [
            RadioButtonList(
              name: "Não quero ${element.category.toLowerCase()}",
              icon: Icons.category,
            )
          ];

          if (res.isNotEmpty) {

            for (final Variation item in res) {
              element.subVariation.add(item);
              element.isDropDown == true ?
                subVariationDropDownButton.add(
                  DropDownList(
                    name: item.category,
                    icon: Icons.category,
                    onSelected: () {
                      setState(() {
                        element.setValues(item.category);
                        subTotal = 0;
                      });
                    },
                  )
                )
              :
                subVariationRadioListTile.add(
                  RadioButtonList(
                    name: item.category,
                    icon: Icons.category,
                  )
                );
            }

            return StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    
                    DropDown(
                      text: element.category,
                      itemsDropDownButton: subVariationDropDownButton,
                      variavel: element.value == '' ? 'Não quero ${element.category.toLowerCase()}' : element.value,
                      callback: (value) {
                        
                        setState(() {
                          element.setValues(value);
                          element.value = value ?? '';
                          t = subVariationDropDownButton.indexWhere((element) => element.name == value);
                          t--;
                          subTotal = 0;
                        });
                      },
                    ),

                    
                    for (final Variation item in element.subVariation)
                      Builder(
                        builder: (context) {
                          return (t >= 0 && element.value != '' && element.value != 'Não quero ${element.category}') ?
                            (element.subVariation[t] == item) ?
                            FutureBuilder(
                              future: getInfoVariation(item),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return (item.isDropDown == null) ?
                                    FutureBuilder(
                                      future: putTextBoxVariation(item),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Column(
                                            children: subVariations,
                                          );
                                        } else {
                                          return const SizedBox();
                                        }
                                      },
                                    )
                                  : item.isDropDown == true ?
                                    putDropDownVariation(item)
                                  :
                                    putLimitElementVariation(item);
                                } else {
                                  return const SizedBox();
                                }
                              },
                          ) : const SizedBox() : const SizedBox();
                        }
                      ),
                  ],
                );
              }
            );

          } else {
            
            // ------ NÃO encontra sub variação --------

            getInfoVariation(element);

            return (element.isDropDown == null) ?
              await putTextBoxVariation(element)
            : element.isDropDown == true ?
              putDropDownVariation(element)
            :
              putLimitElementVariation(element);
          }
        })
      ],
    );
  }

  Widget verifyAddSection(Variation element) {

    return element.isDropDown != true ?
      SectionVisible(
      nameSection: element.category,
      child: FutureBuilder(
        future: addWidgetVariation(element),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data as Widget;
          } else {
            return const SizedBox();
          }
        },
      ),
    ) : FutureBuilder(
      future: addWidgetVariation(element),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data as Widget;
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Future<void> listItemsMain() async {
    await BusinessInformationController.instance.getInfoCalcValue().then((isHighValue) async {
      await SalesController.instance.idSale().then((idOrder) async {
        await ProductsCartController.instance.listItemCurrent(idOrder, idProduct == 0 ? idVariation = await ProductsCartController.instance.getVariationItem(idOrder) : idVariation).then((List<ProductsCartList> res) {
          isBusinessHighValue = isHighValue ?? false;
          
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

          saveSubTotal = subTotal;
        });
      });
    });
  }

  Future<void> listItemsVariations() async {
    listWidgetVariation.clear();
    variations.clear();

    return await ProductsController.instance.listVariations(idVariation).then((List<Variation> res) {
      if (res.isNotEmpty) {
        for (final Variation item in res) {
          variations.add(item);
          listWidgetVariation.add(verifyAddSection(item));
        }
      }
    });
  }
  
  Future<void> getList() async {
    
    await listItemsMain();

    await listItemsVariations();
  }


  Widget bottom() {
    var formKey = GlobalKey<FormState>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            
          },
          icon: const Icon(Icons.arrow_back_ios_rounded),
          color: globals.primary,
        ),

        Form(
          key: formKey,
          child: SizedBox(
            height: 50,
            width: 140,
            child: TextFieldGeneral(
              label: '', 
              variavel: txtQtd,
              context: context, 
              keyboardType: TextInputType.number,
              ico: null,
              validator: (value) {
                return validatorNumber(value!);
              },
              onChanged: (value) {
                setState(() {
                  calcSubTotal();
                });
              },
              hasSum: true,
              size: const [50, 140],
            ),
          ),
        ),
        
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                globals.primary,
                globals.primary.withOpacity(0.8)
              ]
            )
          ),

          child: ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate() && subTotal != 0) {
                GoRouter.of(context).push('/loading');
                
                bool verification = false;

                await ProductsCartController.instance.isLimitedItemVariationOrProduct(context, productSelect, int.parse(txtQtd.text)).then((value) {
                  if (!value) {
                    
                    return;
                  }

                  verification = value;
                });

                if (!verification) {
                  
                  return;
                }

                int idSale;

                resetSubTotal();

                calcSubTotal();

                await SalesController.instance.idSale().then((res) async {
                  idSale = res;

                  if (idProduct != 0) {
                    await ProductsCartController.instance.add(idSale, idProduct, nameProduct, int.parse(txtQtd.text), idVariation, false);
                    await ProductsController.instance.updateStockProduct(idProduct, int.parse(txtQtd.text));
                  }

                  (variations.map((e) async {
                    if (e.textController.isNotEmpty) {
                      e.textController.entries.forEach((element) async {
                        if (element.value.text != '') {
                          await ProductsCartController.instance.addVariation(idSale, element.key, int.parse(txtQtd.text), e.id!, element.value.text, false);
                        }
                      });
                    }

                    e.productItemSelected.forEach((key, bool value) async {
                      if (value && e.price > 0) {
                        await ProductsCartController.instance.add(idSale, key.id, '', int.parse(txtQtd.text), e.id!, false);
                      }
                    });

                    e.subVariation.map((sub)  {
                      if (e.value == sub.category && sub.productItemSelected.isNotEmpty) {
                        sub.textController.entries.forEach((element) async {
                          if (element.value.text != '') {
                            await ProductsCartController.instance.addVariation(idSale, element.key, int.parse(txtQtd.text), sub.id!, element.value.text, false);
                          }
                        });
                        
                        sub.productItemSelected.forEach((key, bool value) async {
                          
                          if (value && sub.price > 0) {
                            await ProductsCartController.instance.add(idSale, key.id, '', int.parse(txtQtd.text), sub.id!, false);
                          }

                        });
                      }
                    }).toList();
                  }).toList());

                  await ProductsCartController.instance.updateInfoSale(idSale, txtObservation.text, int.parse(txtQtd.text));

                  await SalesController.instance.getTotal().then((res){
                    // SalesControllerController.instance.updateTotal(idSale, res + subTotal);
                    globals.isSelectNewItem = false;
                    
                    
                    GoRouter.of(context).pop();
                    GoRouter.of(context).go('/products');  
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
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              padding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                const Icon(
                  Icons.add_shopping_cart,
                  color: Colors.white,
                  size: 30,
                ),

                const SizedBox(width: 10),

                Text(
                  'R\$ ${subTotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    if (saveSubTotal == 0) {

      getList().then((value) {
        if (mounted) {
          setState(() {
            saveSubTotal = subTotal;
          });
        }
      });
    }

    if (subTotal == 0) {
      calcSubTotal();
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        
        child: AppBar(
          titleSpacing: 0,
          title: const Text(
            'Adicionar ao carrinho',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),

          flexibleSpace: CachedNetworkImage(
            imageUrl: urlImageProduct ?? 'https://lh5.googleusercontent.com/p/AF1QipOBoD7baOHV4zR4Do0NrU7Vsi75ZTRM4eq9UgmL=s443-k-no',
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
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
                      padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            autovalidateMode: autoValidation ? AutovalidateMode.always : AutovalidateMode.disabled,
            child: Column(
              children: [

                idProduct != 0 ?
                  Column(
                    children: [

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: globals.primary, spreadRadius: 1),
                          ],
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: globals.primary.withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                              ),

                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Row(
                                    children: [
                                      Icon(
                                        Icons.info,
                                        color: globals.primary,
                                        size: 30,
                                      ),

                                      const SizedBox(width: 5),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.6,
                                            child: Text(
                                              productSelect.name,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                
                                          
                                          (productSelect.variation!.size != 'UNICO') ?
                                            FutureBuilder(
                                              future: ProductsController.instance.getSizesAndDifferencePriceProducts(priceProduct, nameProduct, idVariation),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                                                  return DropDown(
                                                    itemsDropDownButton: [
                                                      for (final ProductItemList item in snapshot.data as List<ProductItemList>)
                                                        DropDownList(
                                                          name: item.variation!.size,
                                                          icon: snapshot.data![snapshot.data!.indexOf(item)].price == 0 ? Icons.check : null,
                                                          widget: snapshot.data![snapshot.data!.indexOf(item)].price != 0 ? Text(
                                                            snapshot.data![snapshot.data!.indexOf(item)].price.toString(),
                                                            style: TextStyle(
                                                              color: !snapshot.data![snapshot.data!.indexOf(item)].price.isNegative ? Colors.green : Colors.red,
                                                              fontSize: 14,
                                                            ),
                                                          ) : null,
                                                        )
                                                    ],

                                                    variavel: productSelect.variation!.size,

                                                    callback: (value) async {
                                                      setState(() {
                                                        productSelect.variation!.size = value!.replaceAll('Tamanho: ', '');
                                                      });

                                                      ProductsController.instance.getProduct(snapshot.data![snapshot.data!.indexWhere((element) => element.variation!.size == value)].id).then((value) {
                                                        setState(() {
                                                          productSelect = value;
                                                          nameProduct = productSelect.name;
                                                          priceProduct = productSelect.price;
                                                          descriptionProduct = productSelect.description;
                                                          urlImageProduct = productSelect.linkImage;
                                                          variation = productSelect.variation!;
                                                          idVariation = variation.id ?? 0;
                                                          saveSubTotal = 0;
                                                        });
                                                      });
                                                    },

                                                    size: [
                                                      MediaQuery.of(context).size.width - 125, 
                                                      50
                                                    ],
                                                  );
                                                } else if (snapshot.connectionState == ConnectionState.waiting) {
                                                  return const CircularProgressIndicator();
                                                } else {
                                                  return const SizedBox();
                                                }
                                              },
                                            )
                                          :
                                            Container(),
                                        ],
                                      ),
                                    ],
                                  ),

                                  Icon(
                                    getIconCategory(productSelect.variation!.category),
                                    color: globals.primary,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                descriptionProduct ?? 'Sem descrição',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),
                      
                      if (productSelect.variation!.limitItems == null || productSelect.variation!.limitItems == 0 || (productSelect.variation!.limitItems! > items.length + 1))
                        button(
                          'Agregar outro item', 
                          0, 
                          0, 
                          Icons.add, 
                          () async {
                            
                            GoRouter.of(context).go('/products');
                            
                            setState(() {
                              globals.isSelectNewItem = true;
                            });

                            await SalesController.instance.idSale().then((res) async {
                              await ProductsCartController.instance.add(res, idProduct, nameProduct, int.parse(txtQtd.text), idVariation);
                              // await ProductsController.instance.updateStockProduct(idProduct, int.parse(txtQtd.text));
                            });
                          })
                    ],
                  ) : Container(),

                const SizedBox(height: 10),

                if (items.isNotEmpty)
                  SectionVisible(
                    nameSection: 'Itens do produto', 
                    isShowPart: true,
                    child: Column(
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
                                                setState(() {
                                                  items.removeAt(index);
                                                });

                                                await ProductsCartController.instance.deleteItem(items[index].id!, context);
                                                await getList();
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
                    ),
                  ),

                const SizedBox(height: 20),
          
                ConditionalBuilder(
                  condition: saveSubTotal != 0,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 80),
                      child: Column(
                        children: [

                          if (listWidgetVariation.isNotEmpty) 
                            Column(
                              children: listWidgetVariation
                            ) 
                          else 
                            Container(),

                          const SizedBox(height: 10),

                          TextFieldGeneral(
                            label: 'Observações' ,
                            variavel: txtObservation, 
                            keyboardType: TextInputType.text,
                          ),

                          const SizedBox(height: 20),

                          
                        ]
                      ),
                    );
                  },
                  fallback: (context) {
                    return const CircularProgressIndicator();
                  },
                )
              ]
            ),
          ),
        )
      ),

      bottomSheet: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder(
          future: subTotal != 0 ? Future.value(true) : Future.value(false),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
              return bottom();
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Ocorreu um erro ao carregar os dados'),
              );
            } else {
              return bottom();
            }
          },
        ),
      ),
    );
  }
}